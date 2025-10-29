# FROM python:3.12.3-alpine

# COPY ./requirements.txt .

# COPY catalog-info.yaml /app/backstage/catalog/entities/users.yaml

# RUN pip install -r ./requirements.txt

# COPY src /src

# CMD python /src/app.py

FROM node:18-bullseye

# Install system dependencies
RUN apt-get update && apt-get install -y \
  build-essential \
  python3 \
  git \
  nano \
  curl \
  jq \
  && rm -rf /var/lib/apt/lists/*

WORKDIR /app/backstage

# Copy Backstage app files
COPY . .

# Copy catalog file
COPY catalog-info.yaml /app/backstage/catalog/entities/catalog-info.yaml

# Install Backstage dependencies
RUN corepack enable && yarn install

# Build Backstage
RUN yarn build:all

# Expose ports
EXPOSE 3000 7007

# Start Backstage
CMD ["yarn", "start"]