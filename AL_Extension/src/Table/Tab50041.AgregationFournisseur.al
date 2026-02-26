table 50041 "Agregation Fournisseur"
{



    DrillDownPageID = "Entete Fiche Gasoil";
    LookupPageID = "Entete Fiche Gasoil";

    fields
    {
        field(1; "No. Article"; Code[20])
        {
            TableRelation = Item;

            trigger OnValidate()
            begin
                /*
                //>>IBK DSFT 13 07 2010
                //***************Nombre de reception Réel***********
                
                RecRecpLine.SETRANGE("No.","No. Article");
                RecRecpLine.SETRANGE("Buy-from Vendor No.","No. Fournisseur");
                IF RecRecpLine.FINDFIRST THEN
                REPEAT
                  IntCompteurReception+=1;
                UNTIL RecRecpLine.NEXT=0;
                
                "Nbr.Reception Réel":=IntCompteurReception;
                //<<IBK DSFT 13 07 2010
                */

            end;
        }
        field(2; "No. Fournisseur"; Code[20])
        {
            TableRelation = Vendor;

            trigger OnValidate()
            begin

                IF "No. Article" = '' THEN
                    ERROR(Text001);
            end;
        }
        field(3; "Nbr. Reception"; Integer)
        {
        }
        field(4; "Qualité"; Option)
        {
            OptionMembers = " ",Test,"Agrée","Non Agrée";
        }
        field(5; "Date Début"; Date)
        {

            trigger OnValidate()
            begin
                IF ("Date Début" <> 0D) AND ("Date Fin" <> 0D) THEN
                    IF "Date Début" > "Date Fin" THEN ERROR(Text002);
            end;
        }
        field(6; "Date Fin"; Date)
        {

            trigger OnValidate()
            begin
                IF ("Date Début" <> 0D) AND ("Date Fin" <> 0D) THEN
                    IF "Date Début" > "Date Fin" THEN ERROR(Text002);
            end;
        }
    }

    keys
    {
        key(Key1; "No. Article", "No. Fournisseur")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    var
        RecRecpLine: Record 121;
        IntCompteurReception: Integer;
        Text001: Label 'Vous devez insérer l''article';
        Text002: Label 'La date début doit être inférier à la date Fin';
}

