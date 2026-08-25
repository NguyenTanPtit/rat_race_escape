# BÀN GIAO DỰ ÁN: Rat Race Escape
*Cập nhật: 25/08/2026 — 4b (AssetScreen) đã nghiệm thu tay + commit (`f86a169`). Slice 4 còn 4c (gộp phản hồi ván chơi) là đóng. Slice 5 đã có spec chốt, chưa code.*
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

- Lương 11tr, tăng **3,0%/năm** (đã hạ từ 3,5% ở đợt 3b — gap −0,5%/năm vs vật giá là sức ép, course là vũ khí; không course thì margin lương-vs-outflow âm từ ~năm 8). Outflow gốc 10,5tr (sinh hoạt 5 + trọ 3,5 + gửi quê 2 — tách dòng). Lạm phát 3,5%/năm.
- **Courses (3b)**: english 12tr/6th/+3 stress/+8% lương · pro 35tr/12th/+5/+15% · master 90tr/24th/+6/+25%. Giá mua = baseCost × inflationIndex (getter `courseCost` — engine+UI dùng chung; học sớm rẻ hơn). Học 1 khóa 1 lúc, mỗi khóa 1 lần, boost vĩnh viễn nhân vào baseSalary khi tốt nghiệp. Pipeline: StartCourse trả tiền 1 lần; ProcessCourseStudy tick SAU CalculateCashflow (N tháng học = đúng N cú stress, lương mới trả từ tháng SAU tốt nghiệp). UI: UpgradeScreen (route /upgrade, nav mở khóa), snackbar 🎓 crossing completedCourseIds trong main screen (field cục bộ widget).
- **index_fund**: yield 11%/năm trên mệnh giá (per-unit cố định → mua đáy = yield-on-cost cao — cơ chế thưởng bắt đáy), drift 0, vol 2%, reversion 0.03, crash p=0.008 −8%/tháng 5-10 tháng, boom p=0.016 +3%/tháng 6-12, T+1.
- **land**: yield 2,5%, drift 0,55%/tháng, vol 4,5%, reversion 0.02, crash p=0.011 −7,5% 6-12, boom p=0.014 +5,5% 6-12, T+2.
- **gold**: yield 0 ("Không sinh thu nhập — trú ẩn giá trị"), drift 0,35%, vol 2,5%, reversion 0.025, crash NHẸ −2,5% p=0.005 (không sụp khi dịch — điểm sáng trú ẩn), T+0.
- Bảo hiểm y tế 100k/tháng (⚠️ 300k từng làm BH thành kèo lỗ = bài học sai). cashIfInsured: ruột thừa −35/−20tr → −6/−4tr; dịch −8/−15 → −2/−4; ốm vặt −1tr → −200k; đau bụng −3/−10 → −0,6/−2.
- Event 6.2b: dịch bệnh absoluteChance 0.005/tháng (cả 2 option forceMarketCrash index+land 6-9 tháng), mất việc w0.4 treo lương 1-3 tháng, ruột thừa w0.5, vay nóng maxCash:0 (20tr/40%/năm, credit −40), hàng xóm khoe lãi (ratio đất ≥1.25, option all-in 80% cash stress −5!), báo sụp đổ (drawdown index ≥0.25, option bán tháo stress −10!), flash-sale đất −20% (drawdown ≥0.30, mua 30tr).
- Bank 3a: savings 4,5%/năm (real +1%); vay thế chấp 10%/năm, minPayment 2%/tháng, credit ≥700, LTV ≤50% danh mục (getter bankLoanHeadroom; vay nóng không tính là nợ thế chấp). Phí bán tài sản 3%. Dust threshold event 1tr. Leisure 100k/điểm (lạm phát theo), trần 20/tháng. Side job 2,5tr (tăng theo lương)/+8 stress/max 2.
- **Debt crush (3c, engine — chủ dự án duyệt 07/08)**: trong CheckGameStatus, THUA bankruptcy khi `cash < −1×outflow` VÀ `totalDueLoanPayment > baseSalary + passive − outflow` (nợ chỉ có thể phình). Getter `totalDueLoanPayment` trên GameState khớp cách ProcessLoans tính (khoản vay gần trả xong chỉ tính phần còn lại). Dùng BASE salary (treo lương tạm không bị xử oan); dip nông không chết; không nợ không chết. Đường thoát: sự kiện vay nóng bơm +20tr khi cash<0 — đắp được nhưng nuôi spiral.

## 6. BOTS & GATES (market_bots_simulation_test.dart — hàng rào thiết kế + chống gian lận)

9 bot, seeds chuẩn [42, 7, 2026], cap 520 tháng; sweep 20 seed là test SKIP (chạy `--run-skipped --plain-name "SEED SWEEP..."` khi tune). Gate đòn bẩy (Kỷ-Luật-Đòn-Bẩy) chạy thẳng trên 20 seed trong suite thường (quyết định 07/08 — cửa sổ vay chỉ mở sau credit 700 ≈ tháng 100, 3 seed quá ít để đo):

| Bot | Chiến lược | Gate hiện hành (ĐỀU XANH @ 06/08) |
|---|---|---|
| blindDca = "DCA-chuẩn" | BH ngày 1 + **course_english sớm** (mua khi liquid − học phí ≥ 1 tháng outflow; chưa đủ thì nâng sàn đầu tư thêm đúng học phí để dồn tiền), dự trữ 3 tháng trong savings, DCA index | Thắng 3/3 + sweep **20/20**, không chết |
| disciplined | như DCA-chuẩn + bắt đáy (index ≤0.85×trend, dự trữ còn 2 tháng) | avg ≤1.0×DCA (0.990; sweep avg 0.988, max 1.000), mọi seed ≤1.05 |
| **noCourse = "Không-Học"** | y hệt DCA-chuẩn nhưng không bao giờ học | chậm ≥8% HOẶC thua seed (thực tế: 3-seed ratio 1.248; sweep thua 3/20 seed [3, 9, 31337], avg 1.376) |
| noReserve = "Đất-Tất-Tay" | all-in ĐẤT, đệm 1 tháng, không BH | ≥1.08 (thực tế 3.02 — không bao giờ thắng) |
| fomo | mua ratio ≥1.25 all-in, bán tháo drawdown ≥20% | ≥1.4 (thực tế 3.02; sweep avg 2.65) |
| cashHoarder | không bao giờ đầu tư, ôm cash | THUA 3/3 (seed 42: 2,73 tỷ danh nghĩa = 622tr thực) |
| savingsOnly | tất cả vào tiết kiệm, không đầu tư | THUA 3/3 (trú ẩn ≠ lối thoát) |
| **leveragedDisciplined = "Kỷ-Luật-Đòn-Bẩy"** | như disciplined + vay full headroom khi index ≤0.8×trend (van nợ chung miễn mortgage cho bot này), trả dồn khi giá hồi ≥0.95×trend | 20 seed: nhanh hơn DCA ≥10% (thực tế **12,0%**, median 9,1%, tốt nhất 26%), thắng 20/20, không chết |
| **recklessLeverage = "Đòn-Bẩy-Liều"** | vay max khi đất sốt (ratio ≥1.25) đổ hết vào đất, không BH, đệm 1 tháng, không trả nợ ngoài minPayment | CHẾT ≥ nửa seed BẤT KỂ lý do (thực tế 3/3 + sweep 20/20 — toàn burnout, xem ⚠️ dưới) |

⚠️ Ngưỡng mua course **1 tháng đệm** là kết quả chẩn đoán seed 31337: với ngưỡng 2 tháng, seed này không bao giờ tích nổi học phí + đệm → không course → margin âm từ năm 8 → cày side job → burnout tháng 236 (MỌI bot chết). Hạ xuống 1 tháng → 31337 thắng tháng 251, cả sweep 20/20. Bot legacy Smart DCA trong engine_simulation_test cũng học course (ngưỡng 2 tháng cash-only — vẫn xanh, đừng đồng bộ vô cớ).

Bot scorer (calculateOptionScore, có 2 bản sao: engine_simulation_test + market_bots) đã hiểu: cashIfInsured, salarySuspended, marketBuy/Sell penalties, flash-sale bonus. Van sinh tồn chung mọi bot: rút savings → bán vàng→index→đất khi cash+pending<0 → top-up savings trước side job → side job → leisure (cần cash−cost ≥ outflow → float PHẢI 2 tháng, 1 tháng là chết burnout) → trả nợ lãi cao.

**CÁC PHÁT HIẾN THIẾT KẾ ĐÃ KIỂM CHỨNG (đừng lặp lại vòng tune):**
1. Với đích thắng passive-income: **time-in-market thắng timing** → DCA mù nằm trong ~5-10% tối ưu; gate "kỹ năng nhanh hơn 20%" bất khả thi KHÔNG CÓ ĐÒN BẨY (đã thử 5 họ chiến lược + sweep). Khoảng cách thật = kỷ luật vs cảm xúc (×2-2.8). Tham vọng 20% đo lại ở 3c.
2. Bán tài sản nhận tiền ngay = danh mục là quỹ khẩn cấp hoàn hảo → cần T+N. Bot đệm mỏng cầm INDEX ≈ DCA là ĐÚNG đời (index thanh khoản thật) — kẻ cần bài học là all-in đất.
3. Găm tiền chờ giá rẻ THUA mua-sớm; chốt lời index = tự cắt passive → đường thắng chuẩn là thuần index, đất là đồ chơi rủi ro.
4. Tín hiệu tương đối (trailing ratio) đánh lừa ngay sau boom; mỏ neo tuyệt đối = trendPrice.
5. Chuỗi test count: 55 → 142 → ... → 241 → 254 (3b-1) → 264 (3b-2) → 265 (3b-3) → **273 passed + 1 skip** (log Sat Aug 8 00:32:00).
6. **Course sớm mạnh hơn dự trữ đầy** (3b-3): ưu tiên mua course_english trước khi quỹ dự trữ đạt 3 tháng làm DCA nhanh hơn trên MỌI seed và cứu seed chết cấu trúc — dưới gap lương, đầu tư bản thân là khoản đầu tư lợi suất cao nhất đầu game.
7. **TRẢ LỜI câu hỏi treo từ 6.2a** (3c): đòn bẩy nâng khoảng cách kỹ năng từ ~1% (disciplined 0.988) lên **12,0%** trung bình 20 seed — vượt gate 10% nhưng **KHÔNG chạm 20%**. Lý do cấu trúc: cửa sổ vay mở muộn (credit 700 ≈ tháng 100) và chỉ đáng vay lúc crash sâu. Tham vọng 20% chính thức đóng: kỹ năng-có-đòn-bẩy = ~12%, kỷ luật cảm xúc vs FOMO vẫn là ×2-3.
8. **⚠️ Chết-vì-nợ mang mặt burnout** (3c, đã thử 5 hướng: crush theo thu nhập/theo thặng dư, HODL đất, YOLO leisure, vay nóng đắp nợ): persona liều sống cả đời ở stress 76-92 (cày side job triền miên) nên thanh stress đầy TRƯỚC khi núi nợ sập — mọi biến thể đều chết kiệt sức trước khi chạm ngưỡng phá sản. Chủ dự án chốt 07/08: án tử đếm mọi lý do; debt crush giữ trong engine cho người chơi thật (kẻ gồng không chịu bán như bot). ĐỪNG thử flip lại race này bằng chỉnh bot — chỉ đổi được bằng phẫu thuật kinh tế stress (rủi ro cao, chưa duyệt).

## 7. TRẠNG THÁI TASK

**ĐÃ ĐÓNG + COMMIT:** 0→6.5 + batch bugfix (lịch sử cũ, xem git log) · 6.2a Market slice 1 + reorganize (`bf6f97d`) · 6.2b Shocks/BH/vàng/T+N/nhiễu/milestone (`10e319e`) · 2.5 Lạm phát (`52b58f7`) · **3a Ngân hàng** (`295da17` + `3501d99`).
**3b + 3c ĐÃ ĐÓNG + COMMIT** (08/08/2026): `42497da` course engine · `325519f` UpgradeScreen · `cf2c0fc` debt crush + bots đòn bẩy. Người dùng nghiệm thu tay và kết luận: **"game thú vị và khó hơn rồi"** — hướng thiết kế Slice 3 được xác nhận. **SLICE 3 HOÀN TẤT.**
**SLICE 4 ĐANG MỞ — 4a ĐÃ ĐÓNG + COMMIT (`0e3becd`), 4b ĐÃ ĐÓNG + COMMIT (`f86a169`, nghiệm thu tay 25/08/2026; log 288 passed + 1 skip)** — còn 4c gộp phản hồi ván chơi là đóng slice: AssetScreen route /assets + nav "Tài sản" mở khóa (hết ổ khóa trên nav) — 4 khối: 🎯 thanh tiến độ passive/outflow có vạch mốc 25/50/75 + số còn thiếu; 💰 breakdown tài sản ròng (tiền mặt/tiết kiệm + lãi/từng lớp kèm badge lãi-lỗ ▲▼% theo giá vốn + passive + ghi chú T+N/tiền đang về + tách nợ ngân hàng vs nợ nóng) + dòng sức mua thực; 📊 dòng tiền tháng (getter engine, có totalDueLoanPayment) + verdict thặng dư/thâm hụt; 🚨 4 cảnh báo chỉ-hiện-khi-có-chuyện (quỹ khẩn cấp <3 tháng, nợ đè = ĐÚNG điều kiện debt crush, LTV ≥90% trần, tiền mặt chết >3 tháng chi phí — không cảnh báo thì im lặng, cơ chế dạy chứ không phải text). Getters mới trên GameState: passiveProgress, emergencyFundMonths, realNetWorth, averageCostPerUnit, unrealizedGainRate. LƯU Ý spec mục 3 khối 1: cảnh báo "% tụt so với Tết trước" đã BỎ khi code — vô căn cứ toán học vì ApplyInflation nhân passive tài sản đang giữ ×1,035 cùng nhịp chi phí (ghi chú trong spec). Đợt 4a: MoneyDisplay hiện `netWorth` thật + dòng phụ tiền mặt/tiết kiệm/đang về · dòng "Thu nhập thụ động" vào chi tiết dòng tiền · getter `structuralSurplus` dùng chung UI + debt crush · 4 ổ số thô đã qua MoneyFormat (chi tiết dòng tiền, bảng tổng kết tháng, 2 màn kết thúc) · "Net Worth:" → "Tài sản ròng:" + dòng "Sức mua theo giá năm đầu" ở 2 màn kết thúc · **test chống tái phát `expectNoRawMoney`** (bắt mọi chuỗi ≥5 chữ số liên tiếp trong Text — dùng lại được ở mọi widget test sau). Spec: `spec_4_dashboard.md` (chủ dự án chốt hướng 08/08/2026). Tab "Tài sản" = bảng điều khiển: thanh tiến độ passive/outflow, breakdown tài sản ròng + lãi/lỗ danh mục, dòng tiền tháng, 4 cảnh báo sức khỏe tài chính. Nộp 3 đợt: 4a vá màn chính (nhãn "Tài sản ròng" đang hiện `cash`; passive KHÔNG hiển thị ở đâu dù là chỉ số quyết định thắng; **4 chỗ in số tiền THÔ không qua MoneyFormat — chi tiết dòng tiền, bảng tổng kết tháng, 2 màn kết thúc**) → 4b AssetScreen → 4c gộp phản hồi ván chơi. Không đụng kinh tế, không gate bot mới.
**SLICE 5 ĐANG MỞ — 5a cooldownMonths ĐÃ CODE XONG** (25/08/2026, log **294 passed + 1 skip, Tue Aug 25 21:10:45**, +6 test [4 cooldown GenerateEvent + 2 json eventLastFired], chờ duyệt + commit — chủ dự án đã duyệt code 5a song song lúc chờ 4c): `cooldownMonths` trên EventDefinition (parse JSON, default 0) + map `eventLastFired` trong GameState (@Default {} → save cũ tương thích, có test legacy-save) + GenerateEvent lọc cooldown Ở BƯỚC ELIGIBILITY (event đang nguội không chạm RNG → chưa gán cooldown thì draw order y nguyên pre-5a, gates giữ nguyên số) + `_fire` đóng dấu tháng nổ tại MỌI điểm nổ (kể cả absoluteChance + fallback). Ngữ nghĩa: nổ tháng M → chặn tới M+N−1, nổ lại được từ M+N. CHƯA event nào trong JSON gán cooldown — số vào ở 5b. Spec: `spec_5_shock_frequency.md` (từ phản hồi chơi thật 16/08: all-in đệm mỏng "chả có sự kiện nào tiêu tốn cả" — số đo: mất việc 1 lần/12 năm, gộp sốc lớn 1 lần/3,8 năm). Chủ dự án chốt 16/08: KHÔNG gian lận xúc xắc theo ví (dạy bài học sai) mà (1) tăng sốc toàn cục (mất việc w0.4→1.2 + 2 sốc mới: hỏng xe nặng, người nhà nhập viện — CỐ Ý không cashIfInsured) + (2) nhân quả stress→ốm (event kiệt sức minStress 70 — dân all-in cày side job tự dính) + gộp 6.3 (cooldownMonths + bản đồ độ khó). Làm SAU khi đóng Slice 4. Đổi kinh tế → chạy lại toàn bộ gates; đo và báo cáo khoảng cách noReserve/DCA (kỳ vọng tăng từ 3.02).
**BACKLOG:** 6.4 scenario khó 9,5tr (đã chứng minh impossible, cần thiết kế lại) · lạm phát biến động theo năm · kỳ hạn tiết kiệm · thương lượng lương qua event · polish (avatar già, phòng theo tài sản, audio, badge) · dialog stopReason tổng quát (cân nhắc lại).

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

1. **4c — chủ dự án CHƠI TRỌN VÁN** với dashboard mới (đây cũng là lần nghiệm thu thiết kế tổng cho câu hỏi gốc "game có vui không" — lần trước trả lời "nhàm" đã dẫn tới toàn bộ chuỗi slice). Góp ý gom về → sửa đợt nhỏ (chỉ UI/nhãn, không đụng kinh tế) → commit ĐÓNG Slice 4 + ghi kết quả thực tế vào spec 4.
2. **Slice 5** theo `spec_5_shock_frequency.md`: ~~5a cooldownMonths engine~~ (XONG 25/08, xem mục 7) → 5b 3 event mới + tune weight job_loss 0.4→1.2 + gán cooldown (dịch 24/mất việc 12/ruột thừa 12/sốc mới 6-12) + i18n + scorer 2 bản sao, gates 3-seed → 5c sweep 20 seed + bản đồ độ khó + báo cáo khoảng cách noReserve/fomo vs DCA (kỳ vọng tăng từ 3.02). Nhắc: `spec_5_shock_frequency.md` còn untracked — git add kèm commit tới.
