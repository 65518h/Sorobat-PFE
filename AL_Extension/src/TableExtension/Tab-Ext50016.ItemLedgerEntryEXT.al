TableExtension 50016 "Item Ledger EntryEXT" extends "Item Ledger Entry"
{
    fields
    {
        //


        modify("Job No.")
        {
            Caption = 'Job No.';
        }
        modify("Job Task No.")
        {
            Caption = 'Job Task No.';
        }
        modify("Job Purchase")
        {
            Caption = 'Job Purchase';
        }


        field(50000; "N° dossier"; Code[20])
        {
        }
        field(50001; "Centre de Gestion"; Code[20])
        {
            Description = 'HJ DSFT 23-03-2012';
        }
        field(50002; Famille; Code[20])
        {
            Description = 'HJ DSFT 23-03-2012';
        }
        field(50003; "Code Nature"; Code[20])
        {
            Description = 'HJ DSFT 23-03-2012';
            // TableRelation = "Gen. Product Posting Group";
        }
        field(50004; Materiel; Code[20])
        {
            Description = 'HJ DSFT 23-03-2012';
            TableRelation = Resource where(Type = const(Machine));
        }
        field(50005; "N° Affaire"; Code[20])
        {
            Description = 'HJ DSFT 23-03-2012';
            TableRelation = Job;
        }
        field(50006; "Type Index"; Option)
        {
            Description = 'HJ DSFT 26-03-2012';
            OptionMembers = " ",Horaire,Kilometrage;
        }
        field(50007; "Nom Utilisateur"; Code[20])
        {
            Description = 'HJ DSFT 26-03-2012';
            TableRelation = User;
        }
        field(50008; Heure; Time)
        {
            Description = 'HJ DSFT 26-03-2012';
        }
        field(50009; Chauffeur; Code[20])
        {
            Description = 'HJ DSFT 26-03-2012';
            TableRelation = "Shipping Agent";
        }
        field(50010; Destination; Code[20])
        {
            Description = 'HJ DSFT 28-04-2012';
            TableRelation = "Post Code";
        }
        field(50012; "Index Horaire"; Decimal)
        {
            Description = 'HJ DSFT 28-04-2012';
        }
        field(50013; "Index Kilometrique"; Decimal)
        {
            Description = 'HJ DSFT 28-04-2012';
        }
        field(50015; "Magasin Destination"; Code[20])
        {
            Description = 'HJ DSFT 26-03-2012';
        }
        field(50016; "N° Véhicule"; Code[20])
        {
            Description = 'HJ DSFT 29-06-2012';
            TableRelation = Véhicule;
        }
        field(50017; Consommation; Boolean)
        {
            Description = 'HJ DSFT 26-03-2012';
        }
        field(50018; "Consommation Intégré"; Boolean)
        {
            Description = 'HJ DSFT 26-03-2012';
        }
        field(50019; "Num Ligne Commande"; Integer)
        {
            CalcFormula = lookup("Purch. Rcpt. Line"."Order Line No." where("Document No." = field("Document No."),
                                                                             "Line No." = field("Document Line No.")));
            FieldClass = FlowField;
        }
        field(50020; "Numero Commande"; Code[20])
        {
            CalcFormula = lookup("Purch. Rcpt. Line"."Order No." where("Document No." = field("Document No."),
                                                                        "Line No." = field("Document Line No.")));
            FieldClass = FlowField;
        }
        field(50021; Synchronise; Boolean)
        {
        }
        field(50022; "Num Bl Fournisseur"; Code[20])
        {
            CalcFormula = lookup("Purch. Rcpt. Header"."Vendor Shipment No." where("No." = field("Document No.")));
            FieldClass = FlowField;
        }
        field(50023; "Designation Article"; Text[100])
        {
            CalcFormula = Lookup(Item.Description WHERE("No." = FIELD("Item No.")));
            Description = 'HJ SORO';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50024; "Num Sequence Synchro"; Integer)
        {
        }
        field(50025; "Num Sequence Chantier"; Boolean)
        {
            Description = 'HJ SORO 19-05-2015';
        }
        field(50026; Receptioneur; Text[100])
        {
            Description = 'HJ SORO 16-10-2014';
            TableRelation = Salarier;
        }
        field(50027; "Vehicule Transporteur"; Text[30])
        {
            Description = 'HJ SORO 16-10-2014';
        }
        field(50028; Provenance; Text[100])
        {
            Description = 'HJ SORO 12-01-2015';
            TableRelation = Job;
        }
        field(50029; "Variante Production"; Code[20])
        {
            Description = 'HJ SORO 12-01-2015';
        }
        field(50030; Benificiaire; Text[30])
        {
            Description = 'HJ SORO 16-10-2014';
            TableRelation = Salarier;
        }
        field(50031; "Groupe Stock"; Code[20])
        {
            Description = 'HJ SORO 2-05-2015';
            TableRelation = "Inventory Posting Group";
        }
        field(50032; "Marque Vehicule"; Code[20])
        {
            Description = 'HJ SORO 18-11-2015';
            TableRelation = "Marque Véhicule";
        }
        field(50033; "Sous Affectation"; Code[20])
        {
            Description = 'HJ SORO 24-11-2015';
            TableRelation = "Marque Véhicule";
        }
        field(50034; Receptionneur; Text[30])
        {
            Description = 'HJ SORO 10-08-2016';
        }
        field(50035; Centrale; Code[20])
        {
            Description = 'HJ SORO 16-04-2016';
            TableRelation = Location;
        }
        field(50036; "Affectation Marche"; Code[20])
        {
            Description = 'HJ SORO 11-10-2016';
            TableRelation = "Affectation Marche" WHERE(Marche = FIELD("Job No."));
        }
        field(50037; "Sous Affectation Marche"; Code[30])
        {
            Description = 'HJ SORO 24-11-2015';
            TableRelation = "Sous Affectation Marche";
        }
        field(50999; "Num Sequence Syncro"; Integer)
        {
            Description = 'HJ SORO 11-05-2015';
        }
        field(60000; Production; Boolean)
        {
            Description = 'HJ SORO 13-06-2015';
        }
        field(60001; "Alerte Frequence Changement"; Boolean)
        {
        }
        field(60002; "Derniere Date Changement"; Date)
        {
        }
        field(60003; "Date Min Changement"; Date)
        {
        }
        field(60004; Esseyeu; Option)
        {
            OptionMembers = " ",E1,E2,E3,E4,E5,E6,E7,E8,E9,E10;
        }
        field(60005; Position; Option)
        {
            OptionMembers = " ",D1,D2,G1,G2;
        }
        field(8003900; "Job Quantity"; Decimal)
        {
            Caption = 'Job quantity';
            DecimalPlaces = 0 : 5;
            Description = 'HJ SORO 09-02-2017';
        }
    }
    keys
    {

        key(Key22; "Item No.", "Lot No.", "Serial No.", "Posting Date", "Location Code", "Variant Code")
        {
            SumIndexFields = Quantity, "Remaining Quantity";
        }

        key(Key23; "Item No.", "Document No.", "Location Code", Quantity, "Entry No.")
        {
        }

        key(Key24; "Location Code", "Item No.")
        {
        }
        //GL2024
        // key(Key25;"Item Category Code","Product Group Code","Location Code")
        // {
        // }
        key(Key26; "N° Véhicule")
        {
        }
        key(Key27; Synchronise)
        {
        }
        //GL2024
        // key(Key28;Emplacement,"Item No.")
        // {
        // SumIndexFields = Quantity;
        // }
        key(Key29; "Num Sequence Synchro")
        {
        }
        //GL2024
        /*key(Key30;"N° Véhicule","Item No.","Posting Date")
        {
        }
   
        key(Key31;"Posting Date",Famille,"N° Véhicule","Entry Type","Item No.")
        {
        SumIndexFields = Quantity;
        }
     
        key(Key32;Emplacement,"Item No.","Location Code")
        {
        SumIndexFields = Quantity;
        }

        key(Key33;"N° Véhicule","Item No.","Posting Date",Esseyeu,Position)
        {
        }
     
        key(Key34;"Posting Date","Alerte Frequence Changement")
        {
        }

        key(Key35;"Posting Date","N° Véhicule","Item No.")
        {
        }

        key(Key36;"Posting Date","Sous Affectation")
        {
        }*/

        key(Key37; "External Document No.")
        {
        }

        key(Key38; "Item No.", "Job No.")
        {
            SumIndexFields = Quantity;
        }
    }



    /*   trigger OnDelete()
       var
           "// Hj": Integer;
           ValueEntry: Record "Value Entry";
           PurchRcptHeader: Record "Purch. Rcpt. Header";
           PurchRcptLine: Record "Purch. Rcpt. Line";
           ItemApplicationEntry: Record "Item Application Entry";
       begin
           // >> HJ SORO 17-11-2017
           ValueEntry.SETRANGE("Item Ledger Entry No.", "Entry No.");
           IF ValueEntry.FINDFIRST THEN ValueEntry.DELETE;
           ItemApplicationEntry.SETRANGE("Item Ledger Entry No.", "Entry No.");
           ItemApplicationEntry.DELETEALL;
           // >> HJ SORO 17-11-2017
       end;*/


}

