package com.example.candy_crm.model.finance;

public enum Position {
    CEO,
    CONSTRUCTOR1,
    CONSTRUCTOR2,
    SMM,
    IT,
    PR_COMMAND,
    DESIGNER;

    public String toOutput() {
        String res = "";
        switch (this) {
            case CEO -> res = "CEO";
            case CONSTRUCTOR1 -> res = "Конструктор 1";
            case CONSTRUCTOR2 -> res = "Конструктор 2";
            case SMM -> res = "SMM";
            case IT -> res = "Разработчик";
            case PR_COMMAND -> res = "PR команда";
            case DESIGNER -> res = "Дизайнер";
        }
        return res;
    }
}
