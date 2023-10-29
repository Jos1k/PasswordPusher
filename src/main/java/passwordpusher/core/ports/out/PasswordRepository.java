package passwordpusher.core.ports.out;

import passwordpusher.core.model.Password;

public interface PasswordRepository {
    void create(Password password);

    Password get(String passwordId);
}
