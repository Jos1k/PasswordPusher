package passwordpusher.left;

import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import static org.springframework.http.MediaType.APPLICATION_JSON_VALUE;

@RestController
@RequestMapping(value={"/password"}, produces = {APPLICATION_JSON_VALUE})
@Validated
public class PasswordController {
    private final PasswordServiceAdapter passwordServiceAdapter;

    @Autowired
    public PasswordController(PasswordServiceAdapter passwordServiceAdapter){
        this.passwordServiceAdapter = passwordServiceAdapter;
    }
    @PostMapping("/push")
    public PasswordCreated Push(@Valid @RequestBody PasswordCreateCommand command){
        return  passwordServiceAdapter.push(command);
    }
}
