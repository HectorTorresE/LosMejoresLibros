# Los Mejores Libros

> Esta app permite crear 3 tipos de usarios: admin, editor y usuario. Los usuarios pueden comprar libros. Los editores pueden crear libros y editarlos y rembolsar compras. Los administradores pueden ven las venta realizar el pago de regalias a los editores de forma manuel y tambien pien agender el paga de forma automatica.

## Built With

- Ruby
- Ruby on Rails
- Gems
- Bundler
- RSpec
- PostgreSQL

## ERD
![image](https://user-images.githubusercontent.com/31547587/230801449-fa771674-cd01-4b60-8946-13b15f59baf9.png)


### Prerrequisitos
- Ruby
- PostgreSQL
- redis-server
- Sidekiq

### Setup
- Clone this repository in your local machine by using `git clone https://github.com/HectorTorresE/LosMejoresLibros.git`
- Update `config/database.yml` file in order to set a working user/password postgresql account
### Install
Install the dependencies with `bundle install`
### Database
- Crear base de datos con `rails db:create`
- Correr las migraciones con `rails db:migrate`
### Usage
- Iniciar el redis-server con `redis-server`
- Iniciar sidekiq con `bundle exec sidekiq`
- Correr la app con `rails server`
- Navegar a [http://localhost:3000](http://localhost:3000)

## Programador

👤 **Hector Torres**

- GitHub: [@HectorTorres](https://github.com/HectorTorresE)
- Portfolio: [Hectorjte.com](https://www.hectorjte.com/)
- LinkedIn: [@Hectorjte](https://www.linkedin.com/in/hectorjte/)

## 🤝 Contributing

Contributions, issues, and feature requests are welcome!

Feel free to check the [issues page](../../issues/).

## Show your support

Give a ⭐️ if you like this project!

## Acknowledgments

- Hat tip to anyone whose code was used
- Inspiration
- etc
