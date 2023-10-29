package passwordpusher.right.inmemory;

import org.springframework.stereotype.Repository;
import passwordpusher.core.model.Password;
import passwordpusher.core.ports.out.PasswordRepository;

import java.util.ArrayList;

@Repository
public class PasswordRepositoryImp implements PasswordRepository {
    private final static ArrayList<Password> passwords = new ArrayList<>();

    @Override
    public void create(Password password) {
        passwords.add(password);
    }

    @Override
    public Password get(String passwordId) {
        return passwords
                .stream()
                .filter(x->x.id() == passwordId)
                .findFirst()
                .get();
    }
}
