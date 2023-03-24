# Nha Gia Re

**The idea**:

## Project stucture

- assets
  - animation: chứa các file lotifile, animate
  - icons : chứa các ảnh icon để sử dụng
  - images: chứa các ảnh dùng cho app
  - fonts : chứa fonts chữ của app (không cần lắm do dùng google font)
- app

  - core

    - extensions: chứa các phương thức mở rộng cho các giá trị trong app
    - utils: chứa các hàm xử lí chung cho app
    - languages:
      - en: sub english
      - vi: sub vietnamese
    - values
      - app_string: chứa các string chung của app
      - app_value: chứa các giá trị mặc định cho app
      - image: chứa đường dẫn tới các image
    - theme:
      - app_colors: là nơi định nghĩa màu cho cả app
      - text_styles: là nơi định nghĩa textStyle cho cả app

  - data

    - enums: chứa enum tự định nghĩa
    - models: chứa các models của app
    - providers: nơi cung cấp data (api, database, firebase,...)
    - services: chứa các hàm service của app (https, authen_service,...)

  - global_widgets: chứa các widgets được sử dụng nhiều lần trong app

  - modules

    - <module_name>: được đặt tên theo tên chức năng
      - screens: chứa các trang của tính năng
      - widgets: chứa các local widgets chỉ xuất hiện trong tính năng này
      - <module_name>\_controller.dart: Khởi tạo controller cho tính năng
      - <module_name>\_binding.dart: Định nghĩa các hàm và biến cho controller

  - routes
    - app_pages.dart: dẫn các route đến các trang tương ứng
    - app_routes.dart: chứa tên các route

- main.dart

## Resources

- Design Figma:
- Git:
- Firebase:
- Reference codebase: https://github.com/kauemurakami/getx_pattern
