package com.example.demo.entities;

import com.example.demo.entities.userEntities.Entrant;

import javax.persistence.*;

@Entity
@Table(name = "application")
public class Application {

    @Id
    @GeneratedValue(strategy= GenerationType.IDENTITY)
    @Column(name="application_id")
    private int id;

    @Column(name="name")
    private String name;
    @Column(name="faculty_places")
    private int places;
    @Column(name="GPA")
    private float GPA;

    @ManyToOne
    @JoinColumn(name="entrant_id", nullable=false)
    private Entrant entrant;

    @ManyToOne
    @JoinColumn(name="faculty_id", nullable=false)
    private Faculty faculty;

    public Application(float GPA, Entrant entrant, Faculty faculty) {
        this.GPA = GPA;
        this.name = entrant.getSurname() + " " + entrant.getName();
        this.places = faculty.getPlaces();
        this.entrant = entrant;
        this.faculty = faculty;
    }

    public Application(){}

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public float getGPA() {
        return GPA;
    }

    public void setGPA(float GPA) {
        this.GPA = GPA;
    }

    public Entrant getEntrant() {
        return entrant;
    }

    public void setEntrant(Entrant entrant) {
        this.entrant = entrant;
    }

    public Faculty getFaculty() {
        return faculty;
    }

    public void setFaculty(Faculty faculty) {
        this.faculty = faculty;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getPlaces() {
        return places;
    }

    public void setPlaces(int places) {
        this.places = places;
    }
}
