package passwordpusher.core.ports.in;

import org.springframework.stereotype.Service;
import passwordpusher.core.model.Password;
import passwordpusher.core.ports.out.PasswordRepository;

@Service
public class PasswordService {
    private final PasswordRepository passwordRepository;

    public PasswordService(PasswordRepository passwordRepository){
        this.passwordRepository = passwordRepository;
    }

    public Password push(String value){
        var passwordId = java.util.UUID.randomUUID();
        var password = new Password(passwordId.toString(), value);
        passwordRepository.create(password);
        return password;
    }

    public Password retrieve(String passwordId) {
        return passwordRepository.get(passwordId);
    }
}
