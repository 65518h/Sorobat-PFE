PageExtension 50193 "Employee Qualifications_PagEXT" extends "Employee Qualifications"

{
    layout
    {
        addbefore("Qualification Code")
        {
            field("Line No."; Rec."Line No.")
            {
                ApplicationArea = all;
                Editable = false;
            }
        }
    }

    trigger OnClosePage()
    begin
        /*   RecQualification.RESET;
                         RecQualification.SETCURRENTKEY("Employee No.","Line No.");
                         RecQualification.SETRANGE("Employee No.","Employee No.");
                         IF RecQualification.FIND('+') THEN
                           BEGIN
                             IF RecEmploye.GET("Employee No.") THEN
                               RecEmploye.VALIDATE("Qualification Code",RecQualification."Qualification Code");
                               RecEmploye.MODIFY;
                           END;*/
    end;
}