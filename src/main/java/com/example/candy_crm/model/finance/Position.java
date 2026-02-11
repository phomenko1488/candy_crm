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
            case CEO:
                res = "CEO";
                break;
            case CONSTRUCTOR1:
                res = "Конструктор 1";
                break;
            case CONSTRUCTOR2:
                res = "Конструктор 2";
                break;
            case SMM:
                res = "SMM";
                break;
            case IT:
                res = "Разработчик";
                break;
            case PR_COMMAND:
                res = "PR команда";
                break;
            case DESIGNER:
                res = "Дизайнер";
                break;
        }
        return res;
    }
}
