page 50744 "Surveillant Headline"
{
    PageType = HeadlinePart;
    SourceTable = "User Personalization";
    Caption = 'Hello';

    layout
    {
        area(Content)
        {
            group(Headlines)
            {
                field(UserNameG; Txt0001 + UserNameG)
                {
                    ApplicationArea = All;
                    Caption = 'Accueil';
                }
                field(UserNameG2; UserNameL)
                {
                    ApplicationArea = All;
                    Caption = 'Accueil';
                }
            }
        }
    }
    trigger OnOpenPage();
    begin
        UserNameG:='';
        UserNameL:='';
        RecUserG.Reset();
        RecUserG.SetRange("User Name", UserId);
        if RecUserG.FindFirst()then UserNameG:=RecUserG."Full Name";
        RecPerson.CalcFields("User ID");
        RecPerson.RESET();
        RecPerson.SetRange("User ID", UserId);
        if RecPerson.FindFirst()then BEGIN
            RecPerson.CalcFields(Role);
            UserNameL:=RecPerson.Role;
        END;
    end;
    var Txt0001: label 'Bonjour ';
    RecUserG: Record User;
    RecPerson: Record "User Personalization";
    UserNameG: Text;
    UserNameL: Text;
}
