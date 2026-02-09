# 1. uv가 설치된 파이썬 3.12 이미지 사용
FROM ghcr.io/astral-sh/uv:python3.12-bookworm-slim

# 2. 컨테이너 내 작업 디렉토리 설정
WORKDIR /app

# 3. 환경 변수 설정 (파이썬 출력 실시간 확인 및 .pyc 생성 방지)
ENV PYTHONUNBUFFERED=1
ENV PYTHONDONTWRITEBYTECODE=1

# 4. 의존성 파일 복사 및 설치
# --frozen: pyproject.toml 내용을 고정해서 설치
# --no-install-project: 소스 코드를 복사하기 전에 라이브러리부터 설치 (캐싱 활용)
COPY pyproject.toml ./
RUN uv sync --no-install-project

# 5. 나머지 소스 코드 전체 복사
COPY . .

# 6. 실행 시 바로 꺼지지 않고 터미널(Bash)을 유지하도록 설정
CMD ["/bin/bash"]