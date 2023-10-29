package passwordpusher.core;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import passwordpusher.core.model.Password;
import passwordpusher.core.ports.in.PasswordService;
import passwordpusher.core.ports.out.PasswordRepository;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.when;

public class PasswordServiceTest {
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

    @Test
    void shouldGetPasswordOnRetrieve(){
        var passwordId = "someTestPasswordId";
        var passwordValue = "someTestPasswordValue";

        when(passwordRepository.get(passwordId)).thenReturn(new Password(passwordId, passwordValue));

        var result = passwordService.retrieve(passwordId);

        assertNotNull(result);
        assertEquals(passwordId, result.id());
        assertEquals(passwordValue, result.value());
    }
}
