table 50050 "Item Ledger Entry History"
{
    // //STOCK CLA 03/09/04 Ajout Quantité chantier

    Caption = 'Historique Écritures Comptables Article';
    DrillDownPageID = "Item Ledger Entry History";
    LookupPageID = "Item Ledger Entry History";

    fields
    {
        field(1; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
        }
        field(2; "Item No."; Code[20])
        {
            Caption = 'Item No.';
            TableRelation = Item;
        }
        field(3; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
        }
        field(4; "Entry Type"; Enum "Item Ledger Entry Type")
        {
            Caption = 'Entry Type';
        }
        // field(4; "Entry Type"; Option)
        // {
        //     Caption = 'Entry Type';
        //     OptionCaption = 'Achat,Vente,Positif (ajust.),Négatif (ajust.),Transfert,Consommation,Production';
        //     OptionMembers = Purchase,Sale,"Positive Adjmt.","Negative Adjmt.",Transfer,Consumption,Output;
        // }
        field(5; "Source No."; Code[20])
        {
            Caption = 'Source No.';
            TableRelation = IF ("Source Type" = CONST(Customer)) Customer
            ELSE IF ("Source Type" = CONST(Vendor)) Vendor
            ELSE IF ("Source Type" = CONST(Item)) Item;
        }
        field(6; "Document No."; Code[20])
        {
            Caption = 'Document No.';
        }
        field(7; Description; Text[100])
        {
            Caption = 'Description';
        }
        field(8; "Location Code"; Code[10])
        {
            Caption = 'Location Code';
            TableRelation = Location;
        }
        field(12; Quantity; Decimal)
        {
            Caption = 'Quantity';
            DecimalPlaces = 0 : 5;
        }
        field(13; "Remaining Quantity"; Decimal)
        {
            Caption = 'Remaining Quantity';
            DecimalPlaces = 0 : 5;
        }
        field(14; "Invoiced Quantity"; Decimal)
        {
            Caption = 'Invoiced Quantity';
            DecimalPlaces = 0 : 5;
        }
        field(28; "Applies-to Entry"; Integer)
        {
            Caption = 'Applies-to Entry';
        }
        field(29; Open; Boolean)
        {
            Caption = 'Open';
        }
        field(33; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(34; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(36; Positive; Boolean)
        {
            Caption = 'Positive';
        }
        field(40; "Shpt. Method Code"; Code[10])
        {
            Caption = 'Shpt. Method Code';
            TableRelation = "Shipment Method";
        }
        field(41; "Source Type"; Enum "Analysis Source Type")
        {
            Caption = 'Source Type';
        }
        // field(41; "Source Type"; Option)
        // {
        //     Caption = 'Source Type';
        //     OptionCaption = ' ,Client,Fournisseur,Article';
        //     OptionMembers = " ",Customer,Vendor,Item;
        // }
        field(47; "Drop Shipment"; Boolean)
        {
            Caption = 'Drop Shipment';
        }
        field(50; "Transaction Type"; Code[10])
        {
            Caption = 'Transaction Type';
            TableRelation = "Transaction Type";
        }
        field(51; "Transport Method"; Code[10])
        {
            Caption = 'Transport Method';
            TableRelation = "Transport Method";
        }
        field(52; "Country/Region Code"; Code[10])
        {
            Caption = 'Country/Region Code';
            TableRelation = "Country/Region";
        }
        field(59; "Entry/Exit Point"; Code[10])
        {
            Caption = 'Entry/Exit Point';
            TableRelation = "Entry/Exit Point";
        }
        field(60; "Document Date"; Date)
        {
            Caption = 'Document Date';
        }
        field(61; "External Document No."; Code[20])
        {
            Caption = 'External Document No.';
        }
        field(62; "Area"; Code[10])
        {
            Caption = 'Area';
            TableRelation = Area;
        }
        field(63; "Transaction Specification"; Code[10])
        {
            Caption = 'Transaction Specification';
            TableRelation = "Transaction Specification";
        }
        field(64; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
            TableRelation = "No. Series";
        }
        field(70; "Reserved Quantity"; Decimal)
        {
            CalcFormula = Sum("Reservation Entry"."Quantity (Base)" WHERE("Source ID" = CONST(),
                                                                           "Source Ref. No." = FIELD("Entry No."),
                                                                           "Source Type" = CONST(32),
                                                                           "Source Subtype" = CONST(0),
                                                                           "Source Batch Name" = CONST(),
                                                                           "Source Prod. Order Line" = CONST(0),
                                                                           "Reservation Status" = CONST(Reservation)));
            Caption = 'Reserved Quantity';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(79; "Document Type"; Enum "Item Ledger Document Type")
        {
            Caption = 'Document Type';
        }
        // field(79; "Document Type"; Option)
        // {
        //     Caption = 'Document Type';
        //     OptionCaption = ',Expédition vente,Facture vente,Réception retour vente,Avoir vente,Réception achat,Facture achat,Expédition retour achat,Avoir achat,Expédition transfert,Réception transfert,Expédition service,Facture service,Avoir service';
        //     OptionMembers = " ","Sales Shipment","Sales Invoice","Sales Return Receipt","Sales Credit Memo","Purchase Receipt","Purchase Invoice","Purchase Return Shipment","Purchase Credit Memo","Transfer Shipment","Transfer Receipt","Service Shipment","Service Invoice","Service Credit Memo";
        // }
        field(80; "Document Line No."; Integer)
        {
            Caption = 'Document Line No.';
        }
        field(90; "Order Type"; Enum "Inventory Order Type")
        {
            Caption = 'Order Type';
            Editable = false;
        }
        field(91; "Order No."; Code[20])
        {
            Caption = 'Order No.';
            Editable = false;
        }
        field(92; "Order Line No."; Integer)
        {
            Caption = 'Order Line No.';
            Editable = false;
        }
        field(480; "Dimension Set ID"; Integer)
        {
            Caption = 'Dimension Set ID';
            Editable = false;
            TableRelation = "Dimension Set Entry";

            trigger OnLookup()
            begin
                //Rec.ShowDimensions();
            end;
        }
        field(481; "Shortcut Dimension 3 Code"; Code[20])
        {
            CaptionClass = '1,2,3';
            Caption = 'Shortcut Dimension 3 Code';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup("Dimension Set Entry"."Dimension Value Code" where("Dimension Set ID" = field("Dimension Set ID"),
                                                                                    "Global Dimension No." = const(3)));
        }
        field(482; "Shortcut Dimension 4 Code"; Code[20])
        {
            CaptionClass = '1,2,4';
            Caption = 'Shortcut Dimension 4 Code';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup("Dimension Set Entry"."Dimension Value Code" where("Dimension Set ID" = field("Dimension Set ID"),
                                                                                    "Global Dimension No." = const(4)));
        }
        field(483; "Shortcut Dimension 5 Code"; Code[20])
        {
            CaptionClass = '1,2,5';
            Caption = 'Shortcut Dimension 5 Code';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup("Dimension Set Entry"."Dimension Value Code" where("Dimension Set ID" = field("Dimension Set ID"),
                                                                                    "Global Dimension No." = const(5)));
        }
        field(484; "Shortcut Dimension 6 Code"; Code[20])
        {
            CaptionClass = '1,2,6';
            Caption = 'Shortcut Dimension 6 Code';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup("Dimension Set Entry"."Dimension Value Code" where("Dimension Set ID" = field("Dimension Set ID"),
                                                                                    "Global Dimension No." = const(6)));
        }
        field(485; "Shortcut Dimension 7 Code"; Code[20])
        {
            CaptionClass = '1,2,7';
            Caption = 'Shortcut Dimension 7 Code';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup("Dimension Set Entry"."Dimension Value Code" where("Dimension Set ID" = field("Dimension Set ID"),
                                                                                    "Global Dimension No." = const(7)));
        }
        field(486; "Shortcut Dimension 8 Code"; Code[20])
        {
            CaptionClass = '1,2,8';
            Caption = 'Shortcut Dimension 8 Code';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup("Dimension Set Entry"."Dimension Value Code" where("Dimension Set ID" = field("Dimension Set ID"),
                                                                                    "Global Dimension No." = const(8)));
        }
        field(904; "Assemble to Order"; Boolean)
        {
            AccessByPermission = TableData "BOM Component" = R;
            Caption = 'Assemble to Order';
        }
        field(1000; "Job No."; Code[20])
        {
            Caption = 'Job No.';
            TableRelation = Job."No.";
        }
        field(1001; "Job Task No."; Code[20])
        {
            Caption = 'Job Task No.';
            TableRelation = "Job Task"."Job Task No." WHERE("Job No." = FIELD("Job No."));
        }
        field(1002; "Job Purchase"; Boolean)
        {
            Caption = 'Job Purchase';
        }

        field(5401; "Prod. Order No."; Code[20])
        {
            Caption = 'Prod. Order No.';
        }

        field(5402; "Variant Code"; Code[10])
        {
            Caption = 'Variant Code';
            TableRelation = "Item Variant".Code WHERE("Item No." = FIELD("Item No."));
        }
        field(5404; "Qty. per Unit of Measure"; Decimal)
        {
            Caption = 'Qty. per Unit of Measure';
            DecimalPlaces = 0 : 5;
        }
        field(5407; "Unit of Measure Code"; Code[10])
        {
            Caption = 'Unit of Measure Code';
            TableRelation = "Item Unit of Measure".Code WHERE("Item No." = FIELD("Item No."));
        }
        field(5408; "Derived from Blanket Order"; Boolean)
        {
            Caption = 'Derived from Blanket Order';
        }
        field(5700; "Cross-Reference No."; Code[20])
        {
            Caption = 'Cross-Reference No.';
        }
        field(5701; "Originally Ordered No."; Code[20])
        {
            Caption = 'Originally Ordered No.';
            TableRelation = Item;
        }
        field(5702; "Originally Ordered Var. Code"; Code[10])
        {
            Caption = 'Originally Ordered Var. Code';
            TableRelation = "Item Variant".Code WHERE("Item No." = FIELD("Originally Ordered No."));
        }
        field(5703; "Out-of-Stock Substitution"; Boolean)
        {
            Caption = 'Out-of-Stock Substitution';
        }
        field(5704; "Item Category Code"; Code[10])
        {
            Caption = 'Item Category Code';
            TableRelation = "Item Category";
        }
        field(5705; Nonstock; Boolean)
        {
            Caption = 'Nonstock';
        }
        field(5706; "Purchasing Code"; Code[10])
        {
            Caption = 'Purchasing Code';
            TableRelation = Purchasing;
        }
        field(5707; "Product Group Code"; Code[10])
        {
            Caption = 'Product Group Code';
            //  TableRelation = "Product Group".Code WHERE ("Item Category Code"=FIELD("Item Category Code"));
        }
        field(5725; "Item Reference No."; Code[50])
        {
            Caption = 'Item Reference No.';
        }
        field(5740; "Transfer Order No."; Code[20])
        {
            Caption = 'Transfer Order No.';
            Editable = false;
        }
        field(5800; "Completely Invoiced"; Boolean)
        {
            Caption = 'Completely Invoiced';
        }
        field(5801; "Last Invoice Date"; Date)
        {
            Caption = 'Last Invoice Date';
        }
        field(5802; "Applied Entry to Adjust"; Boolean)
        {
            Caption = 'Applied Entry to Adjust';
        }
        field(5803; "Cost Amount (Expected)"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = Sum("Value Entry"."Cost Amount (Expected)" WHERE("Item Ledger Entry No." = FIELD("Entry No.")));
            Caption = 'Cost Amount (Expected)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(5804; "Cost Amount (Actual)"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = Sum("Value Entry"."Cost Amount (Actual)" WHERE("Item Ledger Entry No." = FIELD("Entry No.")));
            Caption = 'Cost Amount (Actual)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(5805; "Cost Amount (Non-Invtbl.)"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = Sum("Value Entry"."Cost Amount (Non-Invtbl.)" WHERE("Item Ledger Entry No." = FIELD("Entry No.")));
            Caption = 'Cost Amount (Non-Invtbl.)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(5806; "Cost Amount (Expected) (ACY)"; Decimal)
        {
            AutoFormatExpression = GetCurrencyCode;
            AutoFormatType = 1;
            CalcFormula = Sum("Value Entry"."Cost Amount (Expected) (ACY)" WHERE("Item Ledger Entry No." = FIELD("Entry No.")));
            Caption = 'Cost Amount (Expected) (ACY)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(5807; "Cost Amount (Actual) (ACY)"; Decimal)
        {
            AutoFormatExpression = GetCurrencyCode;
            AutoFormatType = 1;
            CalcFormula = Sum("Value Entry"."Cost Amount (Actual) (ACY)" WHERE("Item Ledger Entry No." = FIELD("Entry No.")));
            Caption = 'Cost Amount (Actual) (ACY)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(5808; "Cost Amount (Non-Invtbl.)(ACY)"; Decimal)
        {
            AutoFormatExpression = GetCurrencyCode;
            AutoFormatType = 1;
            CalcFormula = Sum("Value Entry"."Cost Amount (Non-Invtbl.)(ACY)" WHERE("Item Ledger Entry No." = FIELD("Entry No.")));
            Caption = 'Cost Amount (Non-Invtbl.)(ACY)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(5813; "Purchase Amount (Expected)"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = Sum("Value Entry"."Purchase Amount (Expected)" WHERE("Item Ledger Entry No." = FIELD("Entry No.")));
            Caption = 'Purchase Amount (Expected)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(5814; "Purchase Amount (Actual)"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = Sum("Value Entry"."Purchase Amount (Actual)" WHERE("Item Ledger Entry No." = FIELD("Entry No.")));
            Caption = 'Purchase Amount (Actual)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(5815; "Sales Amount (Expected)"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = Sum("Value Entry"."Sales Amount (Expected)" WHERE("Item Ledger Entry No." = FIELD("Entry No.")));
            Caption = 'Sales Amount (Expected)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(5816; "Sales Amount (Actual)"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = Sum("Value Entry"."Sales Amount (Actual)" WHERE("Item Ledger Entry No." = FIELD("Entry No.")));
            Caption = 'Sales Amount (Actual)';
            Editable = false;
            FieldClass = FlowField;
        }
        field(5817; Correction; Boolean)
        {
            Caption = 'Correction';
        }
        field(5818; "Shipped Qty. Not Returned"; Decimal)
        {
            Caption = 'Shipped Qty. Not Returned';
            DecimalPlaces = 0 : 5;
        }
        field(5832; "Prod. Order Line No."; Integer)
        {
            Caption = 'Prod. Order Line No.';
        }
        field(5833; "Prod. Order Comp. Line No."; Integer)
        {
            Caption = 'Prod. Order Comp. Line No.';
        }
        field(5900; "Service Order No."; Code[20])
        {
            Caption = 'Service Order No.';
        }
        field(6500; "Serial No."; Code[20])
        {
            Caption = 'Serial No.';

            trigger OnLookup()
            begin
                //    ItemTrackingMgt.LookupLotSerialNoInfo("Item No.","Variant Code",0,"Serial No.");
            end;
        }
        field(6501; "Lot No."; Code[20])
        {
            Caption = 'Lot No.';

            trigger OnLookup()
            begin
                //   ItemTrackingMgt.LookupLotSerialNoInfo("Item No.","Variant Code",1,"Lot No.");
            end;
        }
        field(6502; "Warranty Date"; Date)
        {
            Caption = 'Warranty Date';
        }
        field(6503; "Expiration Date"; Date)
        {
            Caption = 'Expiration Date';
        }
        // field(6510; "Item Tracking"; Option)
        // {
        //     Caption = 'Item Tracking';
        //     Editable = false;
        //     OptionCaption = 'Aucun,N° lot,N° lot et de série,N° de série';
        //     OptionMembers = "None","Lot No.","Lot and Serial No.","Serial No.";
        // }
        field(6510; "Item Tracking"; Enum "Item Tracking Entry Type")
        {
            Caption = 'Item Tracking';
            Editable = false;
        }
        field(6515; "Package No."; Code[50])
        {
            Caption = 'Package No.';
            CaptionClass = '6,1';

            trigger OnLookup()
            begin
                ItemTrackingMgt.LookupTrackingNoInfo("Item No.", "Variant Code", "Item Tracking Type"::"Package No.", "Package No.");
            end;
        }
        field(6602; "Return Reason Code"; Code[10])
        {
            Caption = 'Return Reason Code';
            TableRelation = "Return Reason";
        }
        field(10800; "Shipment Method Code"; Code[10])
        {
            Caption = 'Shipment Method Code';
            ObsoleteReason = 'Merge to W1';
            ObsoleteState = Pending;
            TableRelation = "Shipment Method";
            ObsoleteTag = '15.0';
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
        }
        field(50004; Materiel; Code[20])
        {
            Description = 'HJ DSFT 23-03-2012';
            TableRelation = Resource WHERE(Type = CONST(Machine));
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
            CalcFormula = Lookup("Purch. Rcpt. Line"."Order Line No." WHERE("Document No." = FIELD("Document No."),
                                                                             "Line No." = FIELD("Document Line No.")));
            FieldClass = FlowField;
        }
        field(50020; "Numero Commande"; Code[20])
        {
            CalcFormula = Lookup("Purch. Rcpt. Line"."Order No." WHERE("Document No." = FIELD("Document No."),
                                                                        "Line No." = FIELD("Document Line No.")));
            FieldClass = FlowField;
        }
        field(50021; Synchronise; Boolean)
        {
        }
        field(50022; "Num Bl Fournisseur"; Code[20])
        {
            CalcFormula = Lookup("Purch. Rcpt. Header"."Vendor Shipment No." WHERE("No." = FIELD("Document No.")));
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
        field(50026; Receptioneur; Text[1000])
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
        }
    }

    keys
    {
        key(Key1; "Entry No.")
        {
            Clustered = true;
        }
        key(Key2; "Item No.")
        {
        }
        key(Key3; "Item No.", "Posting Date")
        {
        }
        key(Key4; "Item No.", "Entry Type", "Variant Code", "Drop Shipment", "Location Code", "Posting Date")
        {
            SumIndexFields = Quantity, "Invoiced Quantity";
        }
        key(Key5; "Source Type", "Source No.", "Item No.", "Variant Code", "Posting Date")
        {
            SumIndexFields = Quantity;
        }
        key(Key6; "Item No.", Open, "Variant Code", Positive, "Location Code", "Posting Date")
        {
            SumIndexFields = Quantity, "Remaining Quantity";
        }
        key(Key7; "Item No.", Open, "Variant Code", Positive, "Location Code", "Posting Date", "Expiration Date", "Lot No.", "Serial No.")
        {
            SumIndexFields = Quantity, "Remaining Quantity";
        }
        key(Key8; "Country/Region Code", "Entry Type", "Posting Date")
        {
        }
        key(Key9; "Document No.", "Document Type", "Document Line No.")
        {
        }
        // key(Key10; "Prod. Order No.", "Prod. Order Line No.", "Entry Type", "Prod. Order Comp. Line No.")
        // {
        //     MaintainSIFTIndex = false;
        //     SumIndexFields = Quantity;
        // }
        key(Key11; "Item No.", "Applied Entry to Adjust")
        {
        }
        key(Key12; "Item No.", Positive, "Location Code", "Variant Code")
        {
        }
        key(Key13; "Item No.", Open, "Variant Code", Positive, "Expiration Date", "Lot No.", "Serial No.")
        {
            MaintainSIFTIndex = false;
            MaintainSQLIndex = false;
        }
        key(Key14; "Item No.", Open, "Variant Code", "Location Code", "Item Tracking", "Lot No.", "Serial No.")
        {
            MaintainSIFTIndex = false;
            MaintainSQLIndex = false;
            SumIndexFields = "Remaining Quantity";
        }
        key(Key15; "Item No.", "Lot No.", "Serial No.", "Posting Date", "Location Code", "Variant Code")
        {
            SumIndexFields = Quantity, "Remaining Quantity";
        }
        key(Key16; "Item No.", "Document No.", "Location Code", Quantity, "Entry No.")
        {
        }
        key(Key17; "Location Code", "Item No.")
        {
        }
        key(Key18; "Item Category Code", "Product Group Code", "Location Code")
        {
        }
        key(Key19; "N° Véhicule")
        {
        }
        key(Key20; Synchronise)
        {
        }
        key(Key21; "Num Sequence Synchro")
        {
        }
        key(Key22; "Item No.", "Location Code")
        {
        }
        key(Key23; "Job No.", "Code Nature", "Entry Type")
        {
        }
        key(Key24; "Posting Date")
        {
        }
        key(Key25; "Posting Date", "Sous Affectation")
        {
        }
        key(Key26; "N° Véhicule", "Item No.", "Posting Date", Esseyeu, Position)
        {
        }
        key(Key27; "Posting Date", "Alerte Frequence Changement")
        {
        }
        key(Key28; "Posting Date", "N° Véhicule", "Item No.")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Entry No.", Description, "Item No.", "Posting Date", "Entry Type", "Document No.")
        {
        }
    }

    var
        GLSetup: Record 98;
        ReservEntry: Record 337;
        ReservEngineMgt: Codeunit 99000831;
        ReserveItemLedgEntry: Codeunit 99000841;
        ItemTrackingMgt: Codeunit 6500;
        GLSetupRead: Boolean;


    procedure GetCurrencyCode(): Code[10]
    begin
        IF NOT GLSetupRead THEN BEGIN
            GLSetup.GET;
            GLSetupRead := TRUE;
        END;
        EXIT(GLSetup."Additional Reporting Currency");
    end;


    procedure ShowReservationEntries(Modal: Boolean)
    begin
        ReservEngineMgt.InitFilterAndSortingLookupFor(ReservEntry, TRUE);
        // ReserveItemLedgEntry.FilterReservFor(ReservEntry,Rec);
        IF Modal THEN
            page.RUNMODAL(page::"Reservation Entries", ReservEntry)
        ELSE
            page.RUN(page::"Reservation Entries", ReservEntry);
    end;


    procedure SetAppliedEntryToAdjust(AppliedEntryToAdjust: Boolean)
    begin
        IF "Applied Entry to Adjust" <> AppliedEntryToAdjust THEN BEGIN
            "Applied Entry to Adjust" := AppliedEntryToAdjust;
            MODIFY;
        END;
    end;


    procedure SetAvgTransCompletelyInvoiced(): Boolean
    var
        ItemApplnEntry: Record 339;
        InbndItemLedgEntry: Record 32;
        CompletelyInvoiced: Boolean;
    begin
        IF "Entry Type" <> "Entry Type"::Transfer THEN
            EXIT(FALSE);

        ItemApplnEntry.SETCURRENTKEY("Item Ledger Entry No.");
        ItemApplnEntry.SETRANGE("Item Ledger Entry No.", "Entry No.");
        ItemApplnEntry.FIND('-');
        IF NOT "Completely Invoiced" THEN BEGIN
            CompletelyInvoiced := TRUE;
            REPEAT
                InbndItemLedgEntry.GET(ItemApplnEntry."Inbound Item Entry No.");
                IF NOT InbndItemLedgEntry."Completely Invoiced" THEN
                    CompletelyInvoiced := FALSE;
            UNTIL ItemApplnEntry.NEXT = 0;

            IF CompletelyInvoiced THEN BEGIN
                SetCompletelyInvoiced;
                EXIT(TRUE);
            END;
        END;
        EXIT(FALSE);
    end;


    procedure SetCompletelyInvoiced()
    begin
        IF NOT "Completely Invoiced" THEN BEGIN
            "Completely Invoiced" := TRUE;
            MODIFY;
        END;
    end;


    procedure AppliedEntryToAdjustExists(ItemNo: Code[20]): Boolean
    begin
        RESET;
        SETCURRENTKEY("Item No.", "Applied Entry to Adjust");
        SETRANGE("Item No.", ItemNo);
        SETRANGE("Applied Entry to Adjust", TRUE);
        EXIT(FIND('-'));
    end;


    procedure IsOutbndConsump(): Boolean
    begin
        EXIT(("Entry Type" = "Entry Type"::Consumption) AND NOT Positive);
    end;


    procedure IsExactCostReversingPurchase(): Boolean
    begin
        EXIT(
          ("Applies-to Entry" <> 0) AND
          ("Entry Type" = "Entry Type"::Purchase) AND
          ("Invoiced Quantity" < 0));
    end;


    procedure UpdateItemTracking()
    var
        ItemTrackingMgt: Codeunit 6500;

    begin
        //  "Item Tracking" := ItemTrackingMgt.ItemTrackingOption("Lot No.","Serial No.");
    end;


    procedure GetUnitCostLCY(): Decimal
    begin
        IF Quantity = 0 THEN
            EXIT("Cost Amount (Actual)");

        EXIT(ROUND("Cost Amount (Actual)" / Quantity, 0.00001));
    end;
}

