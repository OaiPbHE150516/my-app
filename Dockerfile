#See https://aka.ms/customizecontainer to learn how to customize your debug container and how Visual Studio uses this Dockerfile to build your images for faster debugging.
# Sử dụng image node làm base
FROM node:alpine as build

# Thiết lập thư mục làm việc
WORKDIR /app

# Sao chép file package.json và package-lock.json nếu có, sau đó cài đặt dependencies
COPY package*.json ./
RUN npm install

# Sao chép toàn bộ mã nguồn
COPY . .

# Xây dựng ứng dụng React
RUN npm run build

# Sử dụng image nginx làm base để chạy ứng dụng đã được xây dựng
FROM nginx:alpine
COPY --from=build /app/build /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
