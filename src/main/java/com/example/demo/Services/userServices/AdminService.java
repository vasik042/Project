package com.example.demo.Services.userServices;

import com.example.demo.entities.userEntities.Admin;
import com.example.demo.repositories.userRepos.AdminRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class AdminService {

    private AdminRepo adminRepo;

    @Autowired
    public AdminService(AdminRepo adminRepo){
        this.adminRepo = adminRepo;
    }

    public List<Admin> findAll() {
        return adminRepo.findAll();
    }

    public void deleteById(int id) {
        adminRepo.deleteById(id);
    }

    public Admin findById(int id) {
        return adminRepo.findById(id).get();
    }

    public void save(String email, String password){
        adminRepo.save(new Admin(email, password));
    }

    public void edit(String email, String password, int id){
        adminRepo.edit(email, password, id);
    }

    public Admin findByEmail(String email){
        return adminRepo.findByEmail(email);
    }
}
