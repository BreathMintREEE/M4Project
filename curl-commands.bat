curl -X POST http://localhost:8080/tasks ^
-H "Content-Type: application/json" ^
-d "{\"title\": \"New Task\", \"description\": \"Task description\", \"status\": \"PENDING\", \"dueDate\": \"2024-09-15\"}"

curl -X GET http://localhost:8080/tasks

curl -X GET http://localhost:8080/tasks/1

curl -X PUT http://localhost:8080/tasks/1 ^
-H "Content-Type: application/json" ^
-d "{\"title\": \"Updated Task\", \"description\": \"Updated description\", \"status\": \"COMPLETED\", \"dueDate\": \"2024-10-01\"}"

curl -X DELETE http://localhost:8080/tasks/1
