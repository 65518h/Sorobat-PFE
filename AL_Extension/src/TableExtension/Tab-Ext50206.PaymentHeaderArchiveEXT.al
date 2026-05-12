TableExtension 50206 "Payment Header ArchiveEXT" extends "Payment Header Archive"
{
    fields
    {
        field(50000; "N° Bordereau"; Code[20])
        {
            Description = 'STD V.10';

            trigger OnValidate()
            begin
                //>>DSFT-TRIUM 01/06/09
            end;
        }
        field(50001; "Date Création"; DateTime)
        {
            Description = 'STD V.10';
            Editable = false;
        }
        field(50002; "Créer par"; Code[20])
        {
            Description = 'STD V.10';
            Editable = true;
        }
        field(50003; "Modifié le"; DateTime)
        {
            Description = 'STD V.10';
            Editable = false;
        }
        field(50004; "Modifié par"; Code[20])
        {
            Description = 'STD V.10';
            Editable = true;
        }
        field(50005; Caisse; Boolean)
        {
            Description = 'STD V.10';
        }
        field(50006; "Type paiement"; Option)
        {
            Description = 'STD V.10';
            Editable = true;
            OptionCaption = 'Paiement,Avance';
            OptionMembers = Paiement,Avance;
        }
        field(50007; "Bénéficiaire"; Text[50])
        {
            Description = 'STD V.10';
        }
        field(50008; "Qualité"; Text[50])
        {
            Description = 'STD V.10';
        }
        field(50009; Objet; Option)
        {
            Description = 'STD V.10';
            OptionCaption = ' ,Déplacement,Avance,Prêt,Réglement facture,Divers';
            OptionMembers = " ","Déplacement",Avance,"Prêt","Réglement facture",Divers;
        }
        field(50010; Justificatifs; Option)
        {
            Description = 'STD V.10';
            OptionCaption = ' ,Facture,Ordre de mission';
            OptionMembers = " ",Facture,"Ordre de mission";
        }
        field(50011; "Nombre Impression"; Integer)
        {
            Description = 'STD V.10';
        }
        field(50015; "Nom Tiers"; Text[80])
        {
            CalcFormula = lookup("Payment Line".Libellé where("No." = field("No.")));
            Description = 'STD V.10';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50016; Presentation; Option)
        {
            Description = 'bsk 220311';
            OptionCaption = ' ,2eme Presentation,Bon A Payer,Lettre De Reconstitution';
            OptionMembers = " ","2eme Presentation","Bon A Payer","Lettre De Reconstitution";
        }
        field(50020; "N° CI"; Text[30])
        {
            Description = 'BSK LC';
        }
        field(50021; "DATE D'EMBARQUEMENT"; Date)
        {
            Description = 'BSK LC';
        }
        field(50022; "DATE D'EXPIRATION"; Date)
        {
            Description = 'BSK LC';
        }
        field(50023; "CONDITION DE VENTE"; Text[30])
        {
            Description = 'BSK LC';
        }
        field(50024; "PORT EMBARQUEMENT"; Text[30])
        {
            Description = 'BSK LC';
        }
        field(50025; "PORT DEBARQUEMENT"; Text[30])
        {
            Description = 'BSK LC';
        }
        field(50026; "Mode Echéance"; Option)
        {
            Description = 'BSK LC';
            OptionCaption = 'A VUE,120J DATE BL,90J DATE BL,60J DATE BL,45JJ DATE BL,30J DATE BL';
            OptionMembers = "A VUE","120J DATE BL","90J DATE BL","60J DATE BL","45JJ DATE BL","30J DATE BL";
        }
        field(50027; "Objet Lettre"; Text[250])
        {
            Description = 'BSK LC';
        }
        field(50028; "N° Brouillard"; Text[250])
        {
            Description = 'BSK LC';
        }
        field(50029; Destinataire; Text[100])
        {
            Description = 'BSK LC';
        }
        field(50030; TAUX; Text[100])
        {
            Description = 'BSK LC';
        }
        field(50031; "Durée"; Text[100])
        {
            Description = 'BSK LC';
        }
        field(50032; "Comm Bancaire"; Text[100])
        {
            Description = 'BSK LC';
        }
        field(50033; "Période"; Text[100])
        {
            Description = 'BSK LC';
        }
        field(50034; "Tomber FED"; Text[30])
        {
            Description = 'BSK LC';
        }
        field(50535; ABK; Boolean)
        {
            CalcFormula = lookup("Payment Class".EXT where(Code = field("Payment Class")));
            Description = 'HJ DSFT 04-10-2012';
            FieldClass = FlowField;
        }
        field(50600; Suggestions; Option)
        {
            Caption = 'Suggestions';
            Description = 'STD V.10';
            OptionCaption = 'None,Customer,Vendor,Salary';
            OptionMembers = "None",Customer,Vendor,Salary;
        }
        field(50601; Agence; Code[10])
        {
            Description = 'HJ';
            TableRelation = Agence;
        }
        field(50602; Utilisateur; Code[30])
        {
            Description = 'HJ';
            Editable = true;
            TableRelation = User;
        }
        field(50603; "Validé Par"; Code[30])
        {
            Description = 'HJ';
        }
        field(50604; "Code Recouvreur"; Code[20])
        {
            Description = 'IBK DSFT 20 08 2010';
            TableRelation = "Salesperson/Purchaser";
        }
        field(50605; "Marché"; Code[20])
        {
            Description = 'HJ DELTA 09-02-2014';
            TableRelation = Job;
        }
        field(50606; "Opération"; Option)
        {
            Description = 'HJ DELTA 09-02-2014';
            OptionMembers = "Contrôles Factures",Appro,Technique;
        }
        field(50607; "Mois Echeance Crédit Bancaire"; Integer)
        {
            Description = 'HJ DELTA 09-02-2014';
        }
        field(50608; "Date Echeance à Comptabiliser"; Date)
        {
            Description = 'HJ DELTA 09-02-2014';
        }
    }


}

