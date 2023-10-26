package passwordpusher.left;

import java.util.Objects;

public record PasswordCreated(String passwordId) {
    public PasswordCreated {
        Objects.requireNonNull(passwordId);
    }
}
