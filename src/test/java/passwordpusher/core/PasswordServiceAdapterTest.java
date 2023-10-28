package passwordpusher.core;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import passwordpusher.core.ports.in.PasswordService;
import passwordpusher.core.ports.out.PasswordRepository;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.mockito.Mockito.mock;

public class PasswordServiceAdapterTest {
    private PasswordService passwordService;
    private PasswordRepository passwordRepository;

    @BeforeEach
    void beforeAll(){
        passwordRepository = mock(PasswordRepository.class);
        passwordService = new PasswordService(passwordRepository);
    }

    @Test
    void shouldCreateNewPasswordOnPush(){
        var value = "testPasswordValue";
        var result = passwordService.push(value);

        assertNotNull(result);
        assertNotNull(result.id());
        assertEquals(value, result.value());
    }
}
