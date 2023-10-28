package passwordpusher.core;

import org.junit.jupiter.params.ParameterizedTest;
import org.junit.jupiter.params.provider.Arguments;
import org.junit.jupiter.params.provider.MethodSource;
import passwordpusher.core.model.Password;

import java.util.stream.Stream;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertThrows;

public class PasswordTest {
    @ParameterizedTest
    @MethodSource("invalidIdTestCases")
    void shouldThrowErrorIfIdIsInvalid(String error, String idValue){
        String id = idValue;
        String value = "someValue";

        var exception = assertThrows(IllegalArgumentException.class, () -> new Password(id, value));
        assertEquals(error, exception.getMessage());
    }

    @ParameterizedTest
    @MethodSource("invalidValueTestCases")
    void shouldThrowErrorIfValueIsInvalid(String error, String val){
        String id = "someId";
        String value = val;

        var exception = assertThrows(IllegalArgumentException.class, () -> new Password(id, value));
        assertEquals(error, exception.getMessage());
    }

    private static Stream<Arguments> invalidIdTestCases() {
        return Stream.of(
                Arguments.of("Id cannot be null or empty!", null),
                Arguments.of("Id cannot be null or empty!", ""),
                Arguments.of("Id cannot be null or empty!", "        ")
        );
    }

    private static Stream<Arguments> invalidValueTestCases() {
        return Stream.of(
                Arguments.of("Value cannot be null or empty!", null),
                Arguments.of("Value cannot be null or empty!", ""),
                Arguments.of("Value cannot be null or empty!", "        ")
        );
    }
}
