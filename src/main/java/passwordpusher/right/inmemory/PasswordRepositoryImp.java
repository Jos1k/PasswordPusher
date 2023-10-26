package passwordpusher.right.inmemory;

import org.springframework.stereotype.Component;
import passwordpusher.core.model.Password;
import passwordpusher.core.ports.out.PasswordRepository;

import java.util.ArrayList;

@Component
public class PasswordRepositoryImp implements PasswordRepository {
    private final static ArrayList<Password> passwords = new ArrayList<>();

    @Override
    public void Create(Password password) {
        passwords.add(password);
    }
}
