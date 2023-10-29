package passwordpusher.left;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import passwordpusher.core.model.Password;
import passwordpusher.core.ports.in.PasswordService;

import static junit.framework.TestCase.assertEquals;
import static org.mockito.Mockito.*;

public class PasswordServiceAdapterTest {

    private PasswordServiceAdapter passwordServiceAdapter;
    private PasswordService passwordServiceMock;

    @BeforeEach
    void setUp(){
        passwordServiceMock = mock(PasswordService.class);
        passwordServiceAdapter = new PasswordServiceAdapter(passwordServiceMock);
    }

    @Test
    void shouldProperlyTransformToPasswordCreatedOnPush(){
        var domainPasswordModel = new Password("someTestId", "someTestPassword");
        var expectedDtoModel = new PasswordCreated(domainPasswordModel.id());
        when(passwordServiceMock.push(domainPasswordModel.value())).thenReturn(domainPasswordModel);

        var result = passwordServiceAdapter.push(new PasswordCreateCommand(domainPasswordModel.value()));

        assertEquals(expectedDtoModel, result);
    }

    @Test
    void shouldProperlyTransformToPasswordRetrievedOnRetrieve(){
        var domainPasswordModel = new Password("someTestId", "someTestPassword");
        var expectedDtoModel = new PasswordRetrieved(domainPasswordModel.id(), domainPasswordModel.value());
        when(passwordServiceMock.retrieve(domainPasswordModel.id())).thenReturn(domainPasswordModel);

        var result = passwordServiceAdapter.retrieve(domainPasswordModel.id());

        assertEquals(expectedDtoModel, result);
    }
}
