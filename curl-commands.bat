REM ===================================================
REM Tasks endpoint
REM ===================================================

REM Create a new task
curl -X POST http://localhost:8080/tasks ^
-H "Content-Type: application/json" ^
-d "{\"title\": \"New Task\", \"description\": \"Task description\", \"status\": \"PENDING\", \"dueDate\": \"2025-10-15\"}"

REM Get all tasks
curl -X GET http://localhost:8080/tasks

REM Get task with ID 1
curl -X GET http://localhost:8080/tasks/1

REM Update task with ID 1
curl -X PUT http://localhost:8080/tasks/1 ^
-H "Content-Type: application/json" ^
-d "{\"title\": \"Updated Task\", \"description\": \"Updated description\", \"status\": \"COMPLETED\", \"dueDate\": \"2024-10-01\"}"

REM Delete task with ID 1 (left commented out - task 1 is needed below to attach a subtask)
REM curl -X DELETE http://localhost:8080/tasks/1

REM ===================================================
REM Users endpoint
REM ===================================================

REM Create a new user
curl -X POST http://localhost:8080/users ^
-H "Content-Type: application/json" ^
-d "{\"username\": \"alice\", \"password\": \"password123\"}"

REM Get all users (returns DTOs, no password field)
curl -X GET http://localhost:8080/users

REM Get a specific user by ID (replace 1 with actual ID if different)
curl -X GET http://localhost:8080/users/1

REM Update a user (returns DTO, still no password field)
curl -X PUT http://localhost:8080/users/1 ^
-H "Content-Type: application/json" ^
-d "{\"username\": \"alice_updated\", \"password\": \"newpass456\"}"

REM NOTE: user 1 is deleted further down, AFTER it has been linked to a task below.
REM Do not delete it here or the Task-User relationship test will fail.

REM ===================================================
REM Priorities endpoint (read-only)
REM ===================================================

REM Get all priorities (should return LOW, MEDIUM, HIGH from data.sql)
curl -X GET http://localhost:8080/priorities

REM Get priority with ID 1 (LOW)
curl -X GET http://localhost:8080/priorities/1

REM Get priority with ID 2 (MEDIUM)
curl -X GET http://localhost:8080/priorities/2

REM Get priority with ID 3 (HIGH)
curl -X GET http://localhost:8080/priorities/3

REM ===================================================
REM Task-Priority relationship (many-to-one)
REM ===================================================

REM Create a new task with Priority HIGH (id = 3) -- this becomes task id 2
curl -X POST http://localhost:8080/tasks ^
-H "Content-Type: application/json" ^
-d "{ \"title\": \"Finish project\", \"description\": \"Complete milestone 1\", \"status\": \"PENDING\", \"dueDate\": \"2024-09-30\", \"priority\": { \"id\": 3 } }"
REM Response should show "priorityLevel":"HIGH" -- confirms Task-Priority relationship

REM ===================================================
REM Subtasks endpoint + Task-Subtask relationship (one-to-many)
REM ===================================================

REM Create a new subtask for Task with ID 1 (status defaults to PENDING)
curl -X POST http://localhost:8080/subtasks ^
-H "Content-Type: application/json" ^
-d "{ \"title\": \"Write unit tests\", \"status\": \"PENDING\", \"task\": { \"id\": 1 } }"

REM Confirm the relationship from the Task side: task 1 should now list the subtask
curl -X GET http://localhost:8080/tasks/1
REM Response should show "subtasks":["Write unit tests"] -- confirms Task-Subtask relationship

REM Get all subtasks
curl -X GET http://localhost:8080/subtasks

REM Get subtask with ID 1
curl -X GET http://localhost:8080/subtasks/1

REM Update subtask with ID 1 (set status to COMPLETED)
curl -X PUT http://localhost:8080/subtasks/1 ^
-H "Content-Type: application/json" ^
-d "{ \"title\": \"Write unit tests\", \"status\": \"COMPLETED\", \"task\": { \"id\": 1 } }"

REM ===================================================
REM Task-User relationship (many-to-many)
REM ===================================================

REM Link user 1 (alice_updated) to task 2 (Finish project).
REM Every field is resent, not just "users" -- this endpoint overwrites the whole
REM task on each PUT, so leaving a field out would null it back out.
curl -X PUT http://localhost:8080/tasks/2 ^
-H "Content-Type: application/json" ^
-d "{ \"title\": \"Finish project\", \"description\": \"Complete milestone 1\", \"status\": \"PENDING\", \"dueDate\": \"2024-09-30\", \"priority\": { \"id\": 3 }, \"users\": [{ \"id\": 1 }] }"

REM Confirm the relationship: task 2 should now list the assigned user
curl -X GET http://localhost:8080/tasks/2
REM Response should show "users":["alice_updated"] -- confirms Task-User relationship

REM ===================================================
REM Cleanup deletes
REM ===================================================

REM Delete subtask with ID 1
curl -X DELETE http://localhost:8080/subtasks/1

REM Delete a user (safe now -- already used above to prove the Task-User relationship)
curl -X DELETE http://localhost:8080/users/1
