package passwordpusher.core.model;

public class Password {
    private String _id;
    private String _value;

    public Password(String id, String value) {
        if (id == null || id.trim().isEmpty()) throw new IllegalArgumentException("Id cannot be null or empty!");
        _id = id;

        if (value == null || value.trim().isEmpty())
            throw new IllegalArgumentException("Value cannot be null or empty!");
        _value = value;
    }

    public String id() {
        return _id;
    }

    public String value() {
        return _value;
    }
}
