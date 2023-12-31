package passwordpusher.left;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.WebMvcTest;
import org.springframework.boot.test.mock.mockito.MockBean;
import org.springframework.http.MediaType;
import org.springframework.test.web.servlet.MockMvc;

import static org.mockito.Mockito.when;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultHandlers.print;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.content;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.ObjectWriter;

@WebMvcTest(PasswordController.class)
public class PasswordControllerTest {

    @Autowired
    private MockMvc mockMvc;

    @MockBean
    private PasswordServiceAdapter serviceAdapter;

    private ObjectWriter ow = new ObjectMapper().writer();

    @Test
    public void shouldReturnPasswordIdOnPasswordPush() throws Exception {
        var creatPasswordCommand = new PasswordCreateCommand("TestValue");
        var expectedCreatedResult = new PasswordCreated("TestId");

        when(serviceAdapter.push(creatPasswordCommand)).thenReturn(expectedCreatedResult);

        this.mockMvc
                .perform(post("/password/push")
                        .content(ow.writeValueAsString(creatPasswordCommand))
                        .contentType(MediaType.APPLICATION_JSON_VALUE))
                .andDo(print())
                .andExpect(status().isOk())
                .andExpect(content().string(ow.writeValueAsString(expectedCreatedResult)));
    }

    @Test
    public void shouldReturnErrorIfPasswordValueIsEmptyOnPasswordPush() throws Exception {
        var creatPasswordCommand = new PasswordCreateCommand("");

        this.mockMvc
                .perform(post("/password/push")
                        .content(ow.writeValueAsString(creatPasswordCommand))
                        .contentType(MediaType.APPLICATION_JSON_VALUE))
                .andDo(print())
                .andExpect(status().isBadRequest());
    }

    @Test
    public void shouldReturnPasswordOnPasswordGet() throws Exception{
        var passwordId = "someTestPasswordId";
        var expectedReturnedPassword = new PasswordRetrieved(passwordId, "someTestPasswordValue");

        when(this.serviceAdapter.retrieve(passwordId)).thenReturn(expectedReturnedPassword);

        this.mockMvc
                .perform(get(String.format("/password/retrieve/%s",passwordId)))
                .andDo(print())
                .andExpect(status().isOk())
                .andExpect(content().string(ow.writeValueAsString(expectedReturnedPassword)));
    }

    @Test
    public void shouldReturnNotFoundIfPasswordIdIsEmptyOnPasswordGet() throws Exception{
        var passwordId = "";
        this.mockMvc
                .perform(get(String.format("/password/retrieve/%s",passwordId)))
                .andDo(print())
                .andExpect(status().isNotFound());
    }
}
