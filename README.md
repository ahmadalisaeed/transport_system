# README

* Ruby version
2.6.3

* System dependencies
Docker Composer

* Configuration
`docker-compose build`

* Database creation
`docker-compose run web rails db:create`

* Database initialization
`docker-compose run web rails db:migrate`
`docker-compose run web rails db:seed`

* How to run the test suite
`docker-compose run web rspec`

* To Start the Server
`docker-compose up`

* Assumption
To keep it simple, this system will not expose `source_ids` or `The Source System's Primary Keys`  

* Required API ENDPOINTS 
`localhost:8081/api/v1/vehicles/search` params: `vehicles[arrives_at], vehicles[x], vehicles[y]`
`localhost:8081/api/v1/stops/:stop_id/vehicles/arriving_next` params: `stop_id`
`localhost:8081/api/v1/lines/:id` params: `id`
