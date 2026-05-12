Table 50037 "Référence Chèques"
{
    //  //>>>MBK:05/02/2010: Référence chèque

    LookupPageID = "Liste Utilisateurs";

    fields
    {
        field(1; "N° ligne"; Integer)
        {
        }
        field(2; "Code banque"; Code[20])
        {
            NotBlank = true;
            TableRelation = "Bank Account"."No.";
        }
        field(3; "Référence Chèques"; Code[20])
        {
            NotBlank = true;
        }
        field(4; "N° début"; Integer)
        {
            InitValue = 1;

            trigger OnValidate()
            begin

                if "Dernier N° utilisé" <> 0 then
                    Error(Text02);
                Validate("N° fin", "N° début");
            end;
        }
        field(5; "N° fin"; Integer)
        {
            InitValue = 1;

            trigger OnValidate()
            begin
                if "N° fin" < "N° début" then
                    Error(Text01);
                if "Dernier N° utilisé" <> 0 then
                    Error(Text02);

                Chèquemouvementé_gr.Reset;
                Chèquemouvementé_gr.SetRange("Code banque", "Code banque");
                Chèquemouvementé_gr.SetRange("Référence chèque", "Référence Chèques");
                Chèquemouvementé_gr.DeleteAll;

                for i := "N° début" to "N° fin" do begin
                    Chèquemouvementé_gr.Init;
                    Chèquemouvementé_gr."Code banque" := "Code banque";
                    Chèquemouvementé_gr."Référence chèque" := "Référence Chèques";
                    Chèquemouvementé_gr."N°Chèque" := i;
                    Chèquemouvementé_gr."N° ligne" := "N° ligne";
                    Chèquemouvementé_gr.Insert;
                end;
            end;
        }
        field(6; "Dernier N° utilisé"; Integer)
        {
        }
        field(7; "Dernier date utilisé"; Date)
        {
        }
        field(8; "Date création"; Date)
        {
        }
        field(9; "Date début utilisation"; Date)
        {
        }
        field(10; "Date fin utilisation"; Date)
        {
        }
        field(11; Commentaire; Text[50])
        {
            Description = 'IBK DSFT';
        }
    }

    keys
    {
        key(STG_Key1; "Code banque", "Référence Chèques")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin

        if "Dernier N° utilisé" <> 0 then
            Error(Text02);

        Chèquemouvementé_gr.Reset;
        Chèquemouvementé_gr.SetRange("Code banque", "Code banque");
        Chèquemouvementé_gr.SetRange("Référence chèque", "Référence Chèques");
        Chèquemouvementé_gr.DeleteAll;
    end;

    trigger OnInsert()
    begin
        RéférenceChèques_gr.Reset;
        Nligne_gi := 10000;
        RéférenceChèques_gr.SetRange("Code banque", "Code banque");

        if RéférenceChèques_gr.FindLast then
            "N° ligne" := RéférenceChèques_gr."N° ligne" + Nligne_gi
        else
            "N° ligne" := Nligne_gi;
        "Date création" := WorkDate;


        Validate("N° fin", "N° début");
    end;

    trigger OnRename()
    begin
        if "Dernier N° utilisé" <> 0 then
            Error(Text02);

        Chèquemouvementé_gr.Reset;
        Chèquemouvementé_gr.SetRange("Code banque", xRec."Code banque");
        Chèquemouvementé_gr.SetRange("Référence chèque", xRec."Référence Chèques");
        Chèquemouvementé_gr.DeleteAll;
        Validate("N° fin", "N° début");
    end;

    var
        Nligne_gi: Integer;
        "RéférenceChèques_gr": Record "Référence Chèques";
        Text01: label 'Veuillez saisir une valeur correcte';
        "Chèquemouvementé_gr": Record "Chèque mouvementé";
        i: Integer;
        Text02: label 'Vous ne pouvez pas supprimer cet enregistrement';
}

