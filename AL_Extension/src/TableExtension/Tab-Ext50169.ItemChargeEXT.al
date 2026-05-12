TableExtension 50169 "Item ChargeEXT" extends "Item Charge"
{
    fields
    {
        field(50010; "Affect Frais Annexe"; Boolean)
        {
        }
        field(50011; "Type Frais"; Option)
        {
            OptionCaption = ' ,Frais Financiers,Assurances,Magasinage,Transit,Douane,Frais d''emballage / mise à FOB,Frèt,Frais D''acconage,Dif. Change,Transport,Frais Bancaires,Etat et taxes,Autres Frais';
            OptionMembers = " ","Frais Financiers",Assurances,Magasinage,Transit,Douane,"Frais d'emballage / mise à FOB","Frèt","Frais D'acconage","Dif. Change",Transport,"Frais Bancaires","Etat et taxes","Autres Frais";
        }
        field(50012; "Achat/Vente"; Option)
        {
            OptionMembers = Achat,Vente;
        }
        field(50013; Type; Option)
        {
            OptionCaption = 'Frais,Prestation';
            OptionMembers = Frais,Prestation;
        }
        field(50014; "Compte Achat Associé"; Code[20])
        {
            CalcFormula = lookup("General Posting Setup"."Purch. Account" where("Gen. Bus. Posting Group" = const('LOCAL'),
                                                                                 "Gen. Prod. Posting Group" = field("Gen. Prod. Posting Group")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50015; "Compte Associé"; Code[20])
        {
            CalcFormula = lookup("General Posting Setup"."Sales Account" where("Gen. Bus. Posting Group" = const('LOCAL'),
                                                                                "Gen. Prod. Posting Group" = field("Gen. Prod. Posting Group")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(50016; "Description Bilan"; Text[50])
        {
        }
        field(50017; "Sous Traitance"; Boolean)
        {
        }
    }

    /*  trigger OnBeforeDelete()
      VAR
          LpurchaseLine: Record "Purchase Line";
          TextL001: label 'Suppression Impossible, Charge Liée a une Commande';
      BEGIN
          // >> HJ SORO 19-02-2015
          LpurchaseLine.SETRANGE("No.", "No.");
          IF LpurchaseLine.FINDFIRST THEN ERROR(TextL001);
          // >> HJ SORO 19-02-2015

      END;*/






}

