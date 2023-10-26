package passwordpusher.core.ports.out;

import passwordpusher.core.model.Password;

public interface PasswordRepository {
    void Create(Password password);
}
