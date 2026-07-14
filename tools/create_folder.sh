#!/bin/bash

# Chạy script này ở thư mục root của project Flutter để tạo cấu trúc Clean Architecture
echo "Đang tạo cấu trúc thư mục Clean Architecture..."

# 1. Thư mục Core (Dùng chung cho toàn app)
mkdir -p lib/core/error
mkdir -p lib/core/usecases
mkdir -p lib/core/utils
mkdir -p lib/core/theme
mkdir -p lib/core/constants

# 2. Thư mục DI (Dependency Injection)
mkdir -p lib/di

# 3. Thư mục Features (Chia theo từng tính năng lớn)
# Feature 1: Lõi Game (Main Gameplay & Vòng lặp thời gian)
mkdir -p lib/features/gameplay/domain/entities
mkdir -p lib/features/gameplay/domain/repositories
mkdir -p lib/features/gameplay/domain/usecases
mkdir -p lib/features/gameplay/data/models
mkdir -p lib/features/gameplay/data/datasources
mkdir -p lib/features/gameplay/data/repositories
mkdir -p lib/features/gameplay/presentation/cubit
mkdir -p lib/features/gameplay/presentation/pages
mkdir -p lib/features/gameplay/presentation/widgets

# Feature 2: Ngân hàng & Tín dụng
mkdir -p lib/features/banking/domain/{entities,usecases}
mkdir -p lib/features/banking/presentation/{cubit,pages,widgets}

# Feature 3: Sự kiện & Nhiệm vụ (Events & Quests)
mkdir -p lib/features/events/domain/{entities,usecases}
mkdir -p lib/features/events/data/{models,datasources}
mkdir -p lib/features/events/presentation/{cubit,widgets}

echo "Tạo cấu trúc thư mục thành công!"