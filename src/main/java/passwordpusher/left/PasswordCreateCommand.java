package passwordpusher.left;

import jakarta.validation.constraints.NotBlank;

public record PasswordCreateCommand(@NotBlank(message = "Name is mandatory") String value) {
}
