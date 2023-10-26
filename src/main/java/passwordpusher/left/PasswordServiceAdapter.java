package passwordpusher.left;

import org.springframework.stereotype.Service;
import passwordpusher.core.ports.in.PasswordService;

@Service
public class PasswordServiceAdapter {

    private final PasswordService passwordService;

    public PasswordServiceAdapter(PasswordService passwordService){
        this.passwordService = passwordService;
    }

    public PasswordCreated push(PasswordCreateCommand command){
        var result = passwordService.push(command.value());
        return new PasswordCreated(result.id());
    }
}
