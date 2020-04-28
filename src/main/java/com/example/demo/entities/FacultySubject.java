package com.example.demo.entities;

import javax.persistence.*;

@Entity
@Table(name = "faculty_subject")
public class FacultySubject {

    @Id
    @GeneratedValue(strategy= GenerationType.IDENTITY)
    @Column(name="id")
    int id;

    @Column(name="subject_name")
    String subjectName;
    @Column(name="coefficient")
    float coefficient;

    @ManyToOne
    @JoinColumn(name="faculty_id", nullable=false)
    Faculty faculty;

    public FacultySubject(String subjectName, float coefficient, Faculty faculty) {
        this.subjectName = subjectName;
        this.coefficient = coefficient;
        this.faculty = faculty;
    }

    public FacultySubject(){}

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getSubjectName() {
        return subjectName;
    }

    public void setSubjectName(String subjectName) {
        this.subjectName = subjectName;
    }

    public float getCoefficient() {
        return coefficient;
    }

    public void setCoefficient(float coefficient) {
        this.coefficient = coefficient;
    }

    public Faculty getFaculty() {
        return faculty;
    }

    public void setFaculty(Faculty faculty) {
        this.faculty = faculty;
    }
}
