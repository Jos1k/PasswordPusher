package click.passwordpusher.api;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class StatusController {

    @GetMapping("/status")
    public Status GetStatus(){
        return new Status("OK");
    }
}


