package edu.fscj.cen3024c.taskmanager.entities;

import jakarta.persistence.*;

@Entity
public class Task {

    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Id
    @Column(name = "taskid", nullable = false)
    private Integer id;

    @Column(name = "title", nullable = false)
    private String title;

    @Column(name = "description")
    private String description;

    @Column(name = "status", length = 11, nullable = false)
    private String status; // PENDING, IN_PROGRESS, COMPLETED

    @Column(name = "due_date", length = 10)
    private String dueDate; // YYYY-MM-DD

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getDueDate() {
        return dueDate;
    }

    public void setDueDate(String dueDate) {
        this.dueDate = dueDate;
    }
}