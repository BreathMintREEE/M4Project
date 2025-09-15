REM Create a new task
curl -X POST http://localhost:8080/tasks ^
-H "Content-Type: application/json" ^
-d "{\"title\": \"New Task\", \"description\": \"Task description\", \"status\": \"PENDING\", \"dueDate\": \"2025-10-15\"}"