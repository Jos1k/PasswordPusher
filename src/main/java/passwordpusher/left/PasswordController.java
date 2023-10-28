package passwordpusher.left;

import jakarta.validation.Valid;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;


import static org.springframework.http.MediaType.APPLICATION_JSON_VALUE;

@RestController
@RequestMapping(value={"/password"}, produces = {APPLICATION_JSON_VALUE})
@Validated
public class PasswordController {

    private final PasswordServiceAdapter passwordServiceAdapter;

    public PasswordController(PasswordServiceAdapter passwordServiceAdapter){
        this.passwordServiceAdapter = passwordServiceAdapter;
    }

    @PostMapping("/push")
    public PasswordCreated  Push(@Valid @RequestBody PasswordCreateCommand command){
        return passwordServiceAdapter.push(command);
    }

    @GetMapping("/retrieve/{id}")
    public PasswordRetrieved Push(@PathVariable String id){
        return passwordServiceAdapter.retrieve(id);
    }
}
