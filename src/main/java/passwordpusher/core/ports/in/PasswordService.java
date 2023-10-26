package passwordpusher.core.ports.in;

import org.springframework.stereotype.Component;
import passwordpusher.core.model.Password;
import passwordpusher.core.ports.out.PasswordRepository;

@Component
public class PasswordService {
    private final PasswordRepository passwordRepository;

    public PasswordService(PasswordRepository passwordRepository){
        this.passwordRepository = passwordRepository;
    }

    public Password push(String value){
        var passwordId = java.util.UUID.randomUUID();
        var password = new Password(passwordId.toString(), value);
        passwordRepository.Create(password);
        return password;
    }
}
