TableExtension 50045 "Purch. Inv. HeaderEXT" extends "Purch. Inv. Header"
{
    fields
    {
        modify("Buy-from Vendor No.")
        {
            Caption = 'Buy-from Vendor No.';
        }


        modify("Applies-to Doc. Type")
        {
            Description = '+Note of Expenses ';
        }
        modify("Buy-from Vendor Name")
        {
            Caption = 'Buy-from Vendor Name';
        }
        modify("Buy-from Vendor Name 2")
        {
            Caption = 'Buy-from Vendor Name 2';
        }
        modify("Buy-from Address")
        {
            Caption = 'Buy-from Address';
        }
        modify("Buy-from Address 2")
        {
            Caption = 'Buy-from Address 2';
        }
        modify("Buy-from City")
        {
            Caption = 'Buy-from City';
        }
        modify("Buy-from Contact")
        {
            Caption = 'Buy-from Contact';
        }
        modify("Buy-from Post Code")
        {
            Caption = 'Buy-from Post Code';
        }
        modify("Buy-from County")
        {
            Caption = 'Buy-from County';
        }
        modify("Buy-from Country/Region Code")
        {
            Caption = 'Buy-from Country/Region Code';
        }
        field(50000; "Apply Stamp fiscal"; Boolean)
        {
            Caption = 'Stamp Fiscal';
            Description = 'STD V1.0';
            InitValue = false;
        }
        field(50001; "N° Dossier"; Code[20])
        {
            TableRelation = "Dossiers d'Importation"."N° Dossier" where("N° Fournisseur" = field("Buy-from Vendor No."));
        }
        field(50008; "Date Vérification"; Date)
        {
            Description = 'MBY';
        }
        field(50011; "N° Demande d'achat"; Code[20])
        {
            Editable = false;
        }
        field(50012; "Date DA"; Date)
        {
            Description = 'HJ DSFT 01-02-2013';
        }
        field(50115; Engin; Code[20])
        {
            Description = 'HJ DSFT 15-02-2013';
            TableRelation = Véhicule;
        }
        field(50016; "Description Engin"; Text[50])
        {
            Description = 'HJ DSFT 15-02-2013';
            Editable = false;
        }
        field(50023; Demarcheur; Code[20])
        {
            TableRelation = "Shipping Agent";
        }
        field(50024; Contrat; Boolean)
        {
        }
        /*  field(50025; "Date Bureau Ordre"; Date)
          {
          }*/
        field(50026; "Date Saisie"; Date)
        {
            Description = 'HJ SORO 03-02-2015';
        }
        field(50032; Demandeur; Code[50])
        {
            Description = 'HJ SORO 18-04-2015';
        }
        field(50033; Engins; Code[20])
        {
            Description = 'HJ SORO 18-04-2015';
        }
        field(50036; Utilisateur; Code[50])
        {
        }
        field(50037; Decharge; Boolean)
        {
            Description = 'MH SORO 06/06/2015';
        }
        field(50038; Imprimer; Boolean)
        {
            Description = 'MH SORO 06/06/2015';
        }
        field(50039; "N° Decharge"; Text[30])
        {
            Description = 'MH SORO 06/06/2015';
        }
        field(50040; "Date Decharge"; Date)
        {
            Description = 'MH SORO 06/06/2015';
        }
        field(50042; Simulation; Boolean)
        {
            Description = 'RB SORO 16/03/2016';
        }
        field(50015; "Statut Facture"; Option)
        {
            Description = 'HJ SORO 24-10-2014';
            OptionMembers = "Vérifié Et Comptabilisé","En Cours De Paiement","En Cours De Signature",Signée,Payée,"Payé Et Archivée";
        }
        field(50051; "N° Réglement"; Code[20])
        {
            CalcFormula = lookup("Liste Factures Lettrage"."Numero Reglement" where("Numero Facture" = field("No.")));
            FieldClass = FlowField;
        }
        field(50052; "Date echeance reglement"; Date)
        {
            CalcFormula = lookup("Liste Factures Lettrage"."Date Echeance" where("Numero Facture" = field("No.")));
            FieldClass = FlowField;
        }
        field(50053; "N° piece paiement"; Code[20])
        {
            CalcFormula = lookup("Liste Factures Lettrage"."Numero Piece" where("Numero Facture" = field("No.")));
            FieldClass = FlowField;
        }
        field(50054; "Mode paiement"; Option)
        {
            CalcFormula = lookup("Liste Factures Lettrage"."Mode Paiement" where("Numero Facture" = field("No.")));
            FieldClass = FlowField;
            OptionMembers = " ",Cheque,Traite,Espece;
        }
        field(50055; "Date echeance reglement2"; Date)
        {
            CalcFormula = lookup("Payment Line"."Due Date" where("No." = field("N° Réglement")));
            FieldClass = FlowField;
        }
        /*    field(50056; "Mode paiement2"; Option)
            {
                CalcFormula = lookup("Payment Line"."Mode Paiement" where("No." = field("N° Réglement")));
                FieldClass = FlowField;
                OptionMembers = " ",Cheque,Traite,Espece;
            }*/
        field(50057; "N° piece paiement2"; Code[20])
        {
            CalcFormula = lookup("Payment Line"."External Document No." where("No." = field("N° Réglement")));
            FieldClass = FlowField;
        }
        field(50058; "Date Réclamation"; Date)
        {
            CalcFormula = lookup("Réclamation Facture Achat"."Date Réclamation" where("N° Facture" = field("No.")));
            Description = 'MH SORO 08-09-2020';
            FieldClass = FlowField;
        }
        field(50059; "En instance Controle Facture"; Option)
        {
            Description = 'MH SORO 27-01-2021';
            OptionMembers = " ","En Instance chez Contrôle Facture";
        }
        field(51000; "Pay-to Address Soroubat"; text[100])
        {

        }
        field(60000; "N° Commande"; code[20])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("Purch. Inv. Line"."Order No." WHERE("Document No." = FIELD("No."),
                                                                                                            "Order No." = FILTER(<> '')));
        }
        field(60001; "N° Reception"; code[20])
        {
            FieldClass = FlowField;
            CalcFormula = Lookup("Purch. Inv. Line"."N° Bon Reception" WHERE("Document No." = FIELD("No."),
                                                                                                                   "N° Bon Reception" = FILTER(<> '')));
        }
        field(60002; "Date Bureau Ordre"; Date)
        {
            Description = 'HJ SORO 17-04-2014';
            Editable = false;
        }
        field(60003; "Date Signature"; Date)
        {
            Description = 'HJ SORO 17-04-2014';
            Editable = false;
        }
        field(60004; "Date Paiement"; Date)
        {
            Description = 'HJ SORO 17-04-2014';
            Editable = false;
        }
        field(60005; "Date En Cours Signature"; Date)
        {
            Description = 'HJ SORO 29-09-2015';
            Editable = false;
        }
        field(82750; "Mask Code"; Code[10])
        {
            Caption = 'Masque Code';
            TableRelation = Mask;
        }
        //
        field(8001467; "Vendor Shipment No."; Code[35])
        {
            Caption = 'N° B.L. Fournisseur';
        }
        field(8001900; "Subscription Starting Date"; Date)
        {
            Caption = 'Subscription Starting Date';
        }
        field(8001901; "Subscription End Date"; Date)
        {
            Caption = 'Subscription End Date';
        }
        field(8001902; "Next Invoice Calcultation"; DateFormula)
        {
            Caption = 'Next Invoice Calculation';
        }
        field(8001903; "Next Invoice Date"; Date)
        {
            Caption = 'Next Invoice Date';
        }
        field(8003923; "Job No."; Code[20])
        {
            Caption = 'N° Affaire';
            TableRelation = Job;
        }
    }
    keys
    {
        key(STG_Key10; "N° Decharge")
        {
        }
    }

    trigger OnInsert()
    var
        lMaskMgt: Codeunit "Mask Management";
    begin
        //MASK
        "Mask Code" := lMaskMgt.UserMask;
        //MASK//
    end;

}

