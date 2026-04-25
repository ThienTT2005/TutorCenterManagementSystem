package com.tcms.auth.service;

import com.tcms.auth.dto.LoginRequest;
import com.tcms.exception.BadRequestException;
import com.tcms.user.entity.User;
import com.tcms.user.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class AuthServiceImpl implements AuthService{
    private final UserRepository userRepository;
    private final PasswordEncoder passwordEncoder;

    @Override
    public User login(LoginRequest request){
        if(request.getUsername() == null || request.getUsername().isBlank()
                || request.getPassword() == null || request.getPassword().isBlank()){
            throw new BadRequestException("Vui lòng nhập đầy đủ username và password");
        }

        User user = userRepository.findByUsername(request.getUsername())
                .orElseThrow(() -> new BadRequestException("Sai username hoặc password"));

        if(!Boolean.TRUE.equals(user.getStatus())){
            throw new BadRequestException("Tài khoản đã bị khóa");
        }

        if(!passwordEncoder.matches(request.getPassword(), user.getPassword())){
            throw new BadRequestException("Sai username hoặc password");
        }

        return user;
    }
}
