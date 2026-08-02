# BÀN GIAO DỰ ÁN: Rat Race Escape
*Cập nhật: 28/07/2026 — sau khi đóng đợt 3a (Ngân hàng), nghiệm thu tay OK, CHƯA commit.*
> Tài liệu cho AI tiếp quản. Ngôn ngữ làm việc: **tiếng Việt**. Đọc kèm: `design_core_loop_v2.md` (thiết kế gốc + các quyết định), spec từng slice, và mục 8 (quy trình thẩm định — QUAN TRỌNG NHẤT).

## 1. GAME LÀ GÌ

Flutter mobile game mô phỏng tài chính cá nhân "Thoát vòng chuột đua", giáo dục người trẻ VN. Turn-based: 1 turn = 1 tháng. Tài nguyên: Cash, Savings, Stress (0-100, 100 = burnout), Network, Credit (300-850). **Thắng**: passive income ≥ tổng chi phí tháng. **Thua**: burnout / bankruptcy (cash < −3×outflow) / debtSpiral (credit ≤300 & cash <0) / poorAtRetirement (65 tuổi = 780 ageInMonths; khởi điểm 264 = 22 tuổi). Scenario config-driven qua JSON: `assets/config/scenarios/vn_provincial.json` + i18n `assets/config/i18n/events_vi.json`.

**Triết lý thiết kế đã chốt** (design_core_loop_v2.md): giáo dục = CƠ CHẾ, không phải text; kỹ năng được thưởng là kỷ luật cảm xúc + quản lý thanh khoản, không phải lướt sóng; thua ĐƯỢC nhưng HIẾM (chỉ khi chồng nhiều sai lầm); mọi bài học phải đo được bằng bot.

## 2. MÔ HÌNH LÀM VIỆC (giữ nguyên — đã hoạt động tốt)

- **Người dùng** = chủ dự án, ra quyết định thiết kế, NGHIỆM THU TAY trên thiết bị thật, tự COMMIT.
- **AI** = cố vấn + coder trong một: soạn spec → hỏi chủ dự án chốt các con số/quyết định (AskUserQuestion, 2-4 lựa chọn kèm Recommended) → code theo đợt nhỏ → nộp bằng chứng máy → người dùng nghiệm thu tay → commit → ĐÓNG. **Task đã đóng là bất động.**
- Khi lệch spec/gate không đạt: **CHẨN ĐOÁN TRƯỚC KHI KÊ ĐƠN** (cô lập biến — vd tắt lạm phát để xem thủ phạm), rồi BÁO CÁO cho chủ dự án quyết, không tự xoay số cho khớp. Đã áp dụng thành công 3 lần (gate 20%, thanh khoản T+N, gap lương).

## 3. TECH STACK & KIẾN TRÚC

Clean Architecture. flutter_bloc 9 (Cubit), freezed 3, get_it+injectable, hive_ce, go_router, fpdart (Either), mocktail. Sau refactor move-only (commit `bf6f97d`):

```
lib/features/gameplay/
├── domain/entities/        (game_state, asset, loan, market_class_config/state,
│                            pending_proceed, event_definition, event_effect, ...)
├── domain/usecases/
│   ├── engine/   (process_next_month, calculate_cashflow, apply_inflation,
│   │              process_loans, update_metrics, check_game_status, check_behavioral_insights)
│   ├── events/   (generate_event, apply_event_option)
│   ├── market/   (update_market, buy_market_asset, sell_market_asset)
│   ├── bank/     (manage_savings [deposit+withdraw], take_bank_loan)
│   └── actions/  (buy/sell_asset legacy, pay_debt [nợ chung — cả vay nóng/thẻ],
│                  spend_on_leisure, work_side_job, toggle_health_insurance)
├── presentation/cubit/     (game_engine_cubit + game_engine_state)
├── presentation/pages/     (main_game, invest, bank, new_game, win, game_over, gallery)
└── presentation/widgets/   {common, market, events, dialogs, bank}/
```

**Nguyên tắc bất di bất dịch:**
- Usecase thuần: GameState → Either<Failure, TurnResult> hoặc GameState → GameState. Tham số scenario đi ScenarioConfig → GameStateFactory → GameState (KHÔNG inject config repo vào usecase; MarketClassState ôm luôn config của nó).
- CheckGameStatus chạy sau MỌI hành động. UI không tự tính tiền — một-công-thức-một-nguồn (calculateCashBreakdown dùng chung engine+UI, có cờ insured; netWorth getter duy nhất; mirror trong test phải theo kịp — từng lệch 4,89tr).
- Event effects đụng thị trường PHẢI gọi qua Buy/SellMarketAssetUseCase, cấm viết lại công thức units/phí.
- Presentation CẤM dựng GameState tay — chỉ qua startNewGame. Cấm hardcode số liệu game. So sánh double ngưỡng <0.01.
- RNG: MỘT instance Random seeded dùng chung UpdateMarket + GenerateEvent + ApplyEventOption (thứ tự draw cố định: crash roll → boom roll → noise per class theo thứ tự khai báo). Cubit test dùng mock thủ công resultToReturn — CẤM trộn when/any của mocktail vào file không import nó.
- UI text: các widget mới hardcode tiếng Việt theo tiền lệ LeisureDialog (ARB chỉ dùng cho phần cũ). Tên/nội dung game từ JSON.

## 4. PIPELINE ENGINE (thứ tự QUAN TRỌNG trong ProcessNextMonth)

1. copyWith: month+1, age+1, reset event/leisure/sideJobs
2. **ApplyInflation** (chỉ tại Tết calendarMonth==1 && currentMonth>1)
3. **UpdateMarket** (regime ẩn normal/boom/crash + noise + mean reversion về trendPrice; floor 0.15; recentPrices window 12)
4. **CalculateCashflow** (effectiveSalary [0 khi treo lương] + passive + pendingProceeds đáo hạn − totalMonthlyOutflow [gồm premium BH]; savings × (1+rate/12))
5. Giảm salarySuspendedMonths (SAU cashflow → treo N tháng = đúng N tháng không lương)
6. ProcessLoans (lãi /100/12) → CheckBehavioralInsights → UpdateMetrics (credit +2 khi cash≥0) → GenerateEvent → CheckGameStatus

**Lạm phát (mỗi Tết):** chi phí sống/trọ/gửi quê/premium BH/leisureCost ×(1+3,5%); lương + sideJobIncome ×(1+salaryGrowth); passive MỌI asset ×(1+3,5%); inflationIndex tích lũy. **Cash + savings + pendingProceeds KHÔNG nhân = bài học.** GIÁ tài sản giữ giá trị THỰC (tín hiệu thị trường không nhiễu); bù lại BuyMarketAsset nhân passive theo inflationIndex → lợi suất thực không đổi theo thời điểm mua.

**Thanh khoản T+N:** bán tài sản → tiền vào pendingProceeds (tính vào netWorth, KHÔNG tiêu được), đáo hạn qua CalculateCashflow. index T+1 tháng, đất T+2, vàng T+0. Lý do tồn tại: không có nó, danh mục = quỹ khẩn cấp hoàn hảo và game THƯỞNG sự liều (đo được: bot liều nhanh hơn DCA 9%).

**Stop-conditions auto-advance (cubit, crossing-based):** event · insight mới · won/lost · stress crossing 75/90 · Tết (YearlyRecap kèm khối lạm phát + cảnh báo tiền mặt) · cashflowJump (delta-tháng vs delta-tháng, _prevMonthCashDelta) · market crash (drawdown ROLLING-12-THÁNG crossing 20%/40% — KHÔNG dùng đỉnh mọi thời đại, tín hiệu sẽ chết) · boom (trailingRatio crossing 1.25) → MarketDecisionDialog (Múc thêm/Bán bớt/Gồng giữ) · milestone passive crossing 25/50/75% outflow. Session-only fields (marketStopInfo, milestonePercent, buffer lịch sử) CẤM vào GameState; clear ở startNewGame/loadGame/autoAdvance-start; main screen clear-TRƯỚC-khi-show chống re-trigger.

## 5. KINH TẾ ĐÃ TUNE (vn_provincial.json — sửa phải chạy lại bots)

- Lương 11tr, tăng 3,5%/năm (⚠️ đợt 3b SẼ hạ 3,0% — đã duyệt). Outflow gốc 10,5tr (sinh hoạt 5 + trọ 3,5 + gửi quê 2 — tách dòng). Lạm phát 3,5%/năm.
- **index_fund**: yield 11%/năm trên mệnh giá (per-unit cố định → mua đáy = yield-on-cost cao — cơ chế thưởng bắt đáy), drift 0, vol 2%, reversion 0.03, crash p=0.008 −8%/tháng 5-10 tháng, boom p=0.016 +3%/tháng 6-12, T+1.
- **land**: yield 2,5%, drift 0,55%/tháng, vol 4,5%, reversion 0.02, crash p=0.011 −7,5% 6-12, boom p=0.014 +5,5% 6-12, T+2.
- **gold**: yield 0 ("Không sinh thu nhập — trú ẩn giá trị"), drift 0,35%, vol 2,5%, reversion 0.025, crash NHẸ −2,5% p=0.005 (không sụp khi dịch — điểm sáng trú ẩn), T+0.
- Bảo hiểm y tế 100k/tháng (⚠️ 300k từng làm BH thành kèo lỗ = bài học sai). cashIfInsured: ruột thừa −35/−20tr → −6/−4tr; dịch −8/−15 → −2/−4; ốm vặt −1tr → −200k; đau bụng −3/−10 → −0,6/−2.
- Event 6.2b: dịch bệnh absoluteChance 0.005/tháng (cả 2 option forceMarketCrash index+land 6-9 tháng), mất việc w0.4 treo lương 1-3 tháng, ruột thừa w0.5, vay nóng maxCash:0 (20tr/40%/năm, credit −40), hàng xóm khoe lãi (ratio đất ≥1.25, option all-in 80% cash stress −5!), báo sụp đổ (drawdown index ≥0.25, option bán tháo stress −10!), flash-sale đất −20% (drawdown ≥0.30, mua 30tr).
- Bank 3a: savings 4,5%/năm (real +1%); vay thế chấp 10%/năm, minPayment 2%/tháng, credit ≥700, LTV ≤50% danh mục (getter bankLoanHeadroom; vay nóng không tính là nợ thế chấp). Phí bán tài sản 3%. Dust threshold event 1tr. Leisure 100k/điểm (lạm phát theo), trần 20/tháng. Side job 2,5tr (tăng theo lương)/+8 stress/max 2.

## 6. BOTS & GATES (market_bots_simulation_test.dart — hàng rào thiết kế + chống gian lận)

6 bot, seeds chuẩn [42, 7, 2026], cap 520 tháng; sweep 20 seed là test SKIP (chạy `--run-skipped --plain-name "SEED SWEEP..."` khi tune):

| Bot | Chiến lược | Gate hiện hành (ĐỀU XANH @ 28/07) |
|---|---|---|
| blindDca | BH ngày 1, dự trữ 3 tháng (2 cash + 1 savings), DCA index | Thắng 3/3 + sweep 20/20, không chết |
| disciplined | như DCA + bắt đáy (index ≤0.85×trend, dự trữ còn 2 tháng) | avg ≤1.0×DCA (0.986), mọi seed ≤1.05 (sweep max 1.000) |
| noReserve = "Đất-Tất-Tay" | all-in ĐẤT, đệm 1 tháng, không BH | ≥1.08 (thực tế 2.79 — không bao giờ thắng) |
| fomo | mua ratio ≥1.25 all-in, bán tháo drawdown ≥20% | ≥1.4 (thực tế 2.79) |
| cashHoarder | không bao giờ đầu tư, ôm cash | THUA 3/3 (seed 42: 2,73 tỷ danh nghĩa = 622tr thực) |
| savingsOnly | tất cả vào tiết kiệm, không đầu tư | THUA 3/3 (trú ẩn ≠ lối thoát) |

Bot scorer (calculateOptionScore, có 2 bản sao: engine_simulation_test + market_bots) đã hiểu: cashIfInsured, salarySuspended, marketBuy/Sell penalties, flash-sale bonus. Van sinh tồn chung mọi bot: rút savings → bán vàng→index→đất khi cash+pending<0 → top-up savings trước side job → side job → leisure (cần cash−cost ≥ outflow → float PHẢI 2 tháng, 1 tháng là chết burnout) → trả nợ lãi cao.

**CÁC PHÁT HIẾN THIẾT KẾ ĐÃ KIỂM CHỨNG (đừng lặp lại vòng tune):**
1. Với đích thắng passive-income: **time-in-market thắng timing** → DCA mù nằm trong ~5-10% tối ưu; gate "kỹ năng nhanh hơn 20%" bất khả thi KHÔNG CÓ ĐÒN BẨY (đã thử 5 họ chiến lược + sweep). Khoảng cách thật = kỷ luật vs cảm xúc (×2-2.8). Tham vọng 20% đo lại ở 3c.
2. Bán tài sản nhận tiền ngay = danh mục là quỹ khẩn cấp hoàn hảo → cần T+N. Bot đệm mỏng cầm INDEX ≈ DCA là ĐÚNG đời (index thanh khoản thật) — kẻ cần bài học là all-in đất.
3. Găm tiền chờ giá rẻ THUA mua-sớm; chốt lời index = tự cắt passive → đường thắng chuẩn là thuần index, đất là đồ chơi rủi ro.
4. Tín hiệu tương đối (trailing ratio) đánh lừa ngay sau boom; mỏ neo tuyệt đối = trendPrice.
5. Chuỗi test count: 55 → 142 → ... → **241 passed + 1 skip** (log Tue Jul 28 20:11:28).

## 7. TRẠNG THÁI TASK

**ĐÃ ĐÓNG + COMMIT:** 0→6.5 + batch bugfix (lịch sử cũ, xem git log) · 6.2a Market slice 1 + reorganize (`bf6f97d`) · 6.2b Shocks/BH/vàng/T+N/nhiễu/milestone (`10e319e`) · 2.5 Lạm phát (`52b58f7`).
**ĐÃ CODE, NGHIỆM THU TAY OK, CHƯA COMMIT:** **đợt 3a Ngân hàng** (savings + vay thế chấp + BankScreen + bot savingsOnly + reserve-in-savings). → VIỆC ĐẦU TIÊN: commit 3a.
**CHƯA LÀM (spec đã duyệt — `spec_3_active_paths.md`):**
- **3b Nâng cấp bản thân**: 3 courses (12tr/6th/+3stress/+8% lương · 35tr/12th/+5/+15% · 90tr/24th/+6/+25%), giá = gốc × inflationIndex, học 1 khóa 1 lúc, mỗi khóa 1 lần, snackbar tốt nghiệp; HẠ salaryGrowthAnnualRate 3,5→3,0% (gap là sức ép, course là vũ khí — lưu ý: gap từng làm DCA-không-course chỉ thắng 17/20, giờ là TÍNH NĂNG của gate "bot Không-Học chậm ≥8% hoặc thua vài seed", còn DCA-chuẩn CÓ course phải 20/20); UpgradeScreen + mở khóa nav "Nâng cấp".
- **3c Đòn bẩy bots**: bot Kỷ-Luật-Đòn-Bẩy (vay ≤50% LTV khi index ≤0.8×trend, trả khi hồi) gate ≥10% nhanh hơn — ĐO và BÁO CÁO có chạm 20% không; bot Đòn-Bẩy-Liều (vay max mua đất lúc sốt, không BH, đệm 1 tháng) PHẢI CHẾT ≥ nửa số seed (đã duyệt: liều có án tử).
**BACKLOG:** tab "Tài sản" (nav còn khóa) · 6.3 cooldownMonths (dịch bệnh có thể dính 2 lần gần nhau — hạn chế đã biết) + bản đồ độ khó 20 seed · 6.4 scenario khó 9,5tr (đã chứng minh impossible, cần thiết kế lại) · lạm phát biến động theo năm · kỳ hạn tiết kiệm · thương lượng lương qua event · polish (avatar già, phòng theo tài sản, audio, badge) · dialog stopReason tổng quát (cân nhắc lại).

## 8. ⚠️ QUY TRÌNH THẨM ĐỊNH — PHẦN QUAN TRỌNG NHẤT (giữ nguyên từ đầu dự án)

Lịch sử dự án từng có agent gian lận báo cáo (sửa expected cho khớp code sai, nộp log cũ, khai test không tồn tại, xóa test fail). Quy tắc phòng thủ ĐANG HIỆU LỰC:
1. Log sinh bằng MỘT lệnh: `flutter test --reporter expanded --concurrency=1 > run.log 2>&1 && date >> run.log`. Cấm chép tay/ghép. MỘT file log, MỘT timestamp MỚI (trùng lần trước = nộp đồ cũ = từ chối).
2. Test khai phải kèm TÊN CHÍNH XÁC grep được trong log. Kèm `git diff --stat` file test. Log chứa failed/Error:/Compilation mà khai pass = từ chối.
3. Dòng "Tổng test: N (trước M, +x −y kèm lý do)" — chênh âm không giải trình = cờ đỏ.
4. Không tự sửa expected khi lệch spec — báo cáo. Gate bot là con số grep được = hàng rào chống gian lận tự nhiên.
5. Task lớn → TÁCH NHỎ mỗi đợt nộp. Thẩm định nhanh: `tail -3 run.log` · `grep -nE "failed|Error:|Compilation"` · grep từng tên test · đối chiếu tổng.
6. **Unit test không bắt được bug tầng lắp ráp** — mọi bug lớn đều do TAY người dùng bắt. Mọi task UI bắt buộc vòng cầm máy. Widget test màn hẹp (360dp) bắt overflow tốt (đã cứu 2 vụ).

## 9. FILE QUAN TRỌNG

- `design_core_loop_v2.md` — thiết kế gốc + mọi quyết định có ngày tháng. `spec_6_2a_market.md`, `spec_6_2b_shocks.md`, `spec_2_5_inflation.md` — spec + KẾT QUẢ THỰC TẾ từng slice. `spec_3_active_paths.md` — spec 3a/3b/3c đã duyệt (3a xong).
- Test then chốt: `market_bots_simulation_test.dart` (6 bot + gates + SEED SWEEP skip-test) · `engine_simulation_test.dart` (bot legacy 3 seed + invariants — mirror netWorth phải theo kịp engine!) · `event_shocks_engine_test.dart` · `apply_inflation_usecase_test.dart` · `bank_usecases_test.dart` · cubit/widget tests.
- Memory auto của AI (ngoài repo): `~/.claude/.../memory/project-status.md` — trạng thái mới nhất.

## 10. VIỆC MỞ TIẾP THEO (thứ tự)

1. **Commit 3a** (người dùng): `git add -A && git commit -m "feat: slice 3a — bank savings with monthly compounding, collateral-backed mortgage lending, bank screen, savings-based bot reserves"`
2. **Đợt 3b** theo spec mục 2 + gate 4 (mục 3). Cẩn trọng nhất: hạ lương 3,0% RỒI kiểm DCA-có-course sweep 20/20.
3. **Đợt 3c** — trả lời câu hỏi treo lâu nhất: đòn bẩy có cho kỹ năng chạm 20% không. Đo xong báo số thật.
4. Sau Slice 3: người dùng CHƠI TRỌN VÁN nghiệm thu thiết kế tổng (câu hỏi gốc "game có vui không" — lần trước trả lời "nhàm" đã dẫn tới toàn bộ chuỗi slice này).
