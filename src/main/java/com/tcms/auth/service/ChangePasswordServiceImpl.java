package com.tcms.auth.service;

import com.tcms.auth.dto.ChangePasswordRequest;
import com.tcms.exception.BadRequestException;
import com.tcms.user.entity.User;
import com.tcms.user.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class ChangePasswordServiceImpl implements ChangePasswordService {

    private final UserRepository userRepository;
    private final PasswordEncoder passwordEncoder;

    @Override
    public void changePassword(Integer userId, ChangePasswordRequest request) {
        User user = userRepository.findById(userId)
                .orElseThrow(() -> new BadRequestException("Không tìm thấy tài khoản"));

        if (request.getOldPassword() == null || request.getOldPassword().isBlank()) {
            throw new BadRequestException("Vui lòng nhập mật khẩu cũ");
        }

        if (request.getNewPassword() == null || request.getNewPassword().isBlank()) {
            throw new BadRequestException("Vui lòng nhập mật khẩu mới");
        }

        if (request.getNewPassword().length() < 6) {
            throw new BadRequestException("Mật khẩu mới phải có ít nhất 6 ký tự");
        }

        if (!request.getNewPassword().equals(request.getConfirmPassword())) {
            throw new BadRequestException("Xác nhận mật khẩu không khớp");
        }

        if (!passwordEncoder.matches(request.getOldPassword(), user.getPassword())) {
            throw new BadRequestException("Mật khẩu cũ không đúng");
        }

        user.setPassword(passwordEncoder.encode(request.getNewPassword()));
        userRepository.save(user);
    }
}