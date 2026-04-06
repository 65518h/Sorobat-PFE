Table 52048911 Alerte
{
    //LookupPageID = 71489;
    //GL2024  ID dans Nav 2009 : "39001443"
    fields
    {
        field(2; "Date Remplacement"; Date)
        {
            NotBlank = true;
        }
        field(3; "N° Salariée"; Code[20])
        {
            TableRelation = Employee;

            trigger OnValidate()
            begin
                Clear(Sal);
                Sal.Reset;
                if Sal.Get("N° Salariée") then
                    "N° Carte Remplacée" := Sal."N° Cate"
                else
                    Clear("N° Carte Remplacée");
                if "Type Alerte" = 1 then begin
                    Clear(Cnt);
                    Cnt.Reset;
                    Cnt.Get(Sal."Emplymt. Contract Code");
                    "Type Calendar" := Cnt."Type Calendar";
                    "Code Calendar" := Cnt."Code Calendar";
                    "Employee's type" := Cnt."Employee's type";
                    "Regimes of work" := Cnt."Regimes of work";
                    "Date Debut Roulement" := Sal."Date Debut Roulement";
                end;
            end;
        }
        field(4; "N° Remplacant"; Code[20])
        {
            TableRelation = Employee;

            trigger OnValidate()
            begin
                Clear(Sal);
                Sal.Reset;
                if Sal.Get("N° Remplacant") then
                    "N° Carte Remplacant" := Sal."N° Cate"
                else
                    Clear("N° Carte Remplacant");
            end;
        }
        field(5; "Heure Début"; Time)
        {
        }
        field(6; "Heure Fin"; Time)
        {
        }
        field(7; Declencher; Text[100])
        {
        }
        field(8; Utilisateur; Code[10])
        {
        }
        field(9; Date; Date)
        {
        }
        field(10; heure; Time)
        {
        }
        field(11; "Type Alerte"; Option)
        {
            OptionMembers = " ","Seuil Min Article","Delais DA","Vidange Moteur","Vidange Boite","Vidange 1000H","Vidange 2000H","Chaine de destr.","Consommation Gasoil Depasser","Compteur En Panne","Papier Materiel","DA Imminente","Frequence Changement";

            //OptionMembers = " ","Seuil Min Article","Delais DA",Vidange,"Consommation Gasoil Depasser","Compteur En Panne","Papier Materiel","DA Imminente","Frequence Changement";
        }
        field(20; "N° Carte Remplacée"; Code[20])
        {
        }
        field(21; "N° Carte Remplacant"; Code[20])
        {
        }
        field(50000; "Alerte Declencher"; Boolean)
        {
        }
        field(8099010; "Employee's type"; Option)
        {
            Caption = 'Employee''s type';
            OptionCaption = 'Hour based,Month based';
            OptionMembers = "Hour based","Month based";
        }
        field(8099020; "Regimes of work"; Code[10])
        {
            Caption = 'Regime of work';
            TableRelation = "Regimes of work".Code where("Type Calendar" = field("Type Calendar"));

            trigger OnValidate()
            begin
                Clear(Regim);
                if Regim.Get("Regimes of work") then;
                "Type Calendar" := Regim."Type Calendar";
            end;
        }
        field(39001440; "Type Calendar"; Option)
        {
            OptionMembers = " ",Administratif,Roulement;

            trigger OnValidate()
            begin
                Clear("Regimes of work");
                "N° Ligne Roulement" := 0;
                "Date Debut Roulement" := 0D;
            end;
        }
        field(39001441; "Code Calendar"; Code[20])
        {
            TableRelation = if ("Type Calendar" = filter(Roulement)) "Caledar Roulement"."Code calend Roulement"
            else
            if ("Type Calendar" = filter(Administratif)) "Base Calendar".Code;
        }
        field(39001442; "Date Debut Roulement"; Date)
        {
        }
        field(39001443; "N° Ligne Roulement"; Integer)
        {
            TableRelation = "Line Calendar Roulement"."Line no." where(Code = field("Code Calendar"));
        }
        field(39001444; "Date Fin Changement"; Date)
        {
        }
    }

    keys
    {
        key(STG_Key1; "Type Alerte")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        Utilisateur := UserId;
        Date := Today;
        heure := Time;
    end;

    var
        Sal: Record Employee;
        Regim: Record "Regimes of work";
        Cnt: Record "Employment Contract";
}

