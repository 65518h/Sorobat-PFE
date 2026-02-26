TableExtension 50099 "Default DimensionEXT" extends "Default Dimension"
{
    fields
    {
        /*   modify("No.")
           {
               TableRelation = if ("Table ID" = const(13)) "Salesperson/Purchaser"
               else
               if ("Table ID" = const(15)) "G/L Account"
               else
               if ("Table ID" = const(18)) Customer
               else
               if ("Table ID" = const(23)) Vendor
               else
               if ("Table ID" = const(27)) Item
               else
               if ("Table ID" = const(152)) "Resource Group"
               else
               if ("Table ID" = const(156)) Resource
               else
               if ("Table ID" = const(167)) Job
               else
               if ("Table ID" = const(270)) "Bank Account"
               else
               if ("Table ID" = const(413)) "IC Partner"
               else
               if ("Table ID" = const(5071)) Campaign
               else
               if ("Table ID" = const(5200)) Employee
               else
               if ("Table ID" = const(5600)) "Fixed Asset"
               else
               if ("Table ID" = const(5628)) Insurance
               else
               if ("Table ID" = const(5903)) "Service Order Type"
               else
               if ("Table ID" = const(5904)) "Service Item Group"
               else
               if ("Table ID" = const(5940)) "Service Item"
               else
               if ("Table ID" = const(5714)) "Responsibility Center"
               else
               if ("Table ID" = const(5800)) "Item Charge"
               else
               if ("Table ID" = const(99000754)) "Work Center"
               else
               if ("Table ID" = const(5965)) "Service Contract Header"
               else
               if ("Table ID" = const(5105)) "Customer Template";
           }*/
        field(73754; Replication; Boolean)
        {
            Caption = 'Replication';
            Editable = false;
        }
    }


    trigger OnAfterInsert()
    begin

        //+REF+REPLIC
        wReplicationRef.GETTABLE(Rec);
        wReplicationTrigger.OnInsert(wReplicationRef);
        //+REF+REPLIC//

    end;

    trigger OnAfterModify()
    VAR
        lReplicationRef: RecordRef;
    begin
        //+REF+REPLIC
        lReplicationRef.GETTABLE(xRec);
        wReplicationRef.GETTABLE(Rec);
        wReplicationTrigger.OnModify(wReplicationRef, lReplicationRef);
        //+REF+REPLIC//

    end;

    trigger OnAfterDelete()
    begin
        //+REF+REPLIC
        wReplicationRef.GETTABLE(Rec);
        wReplicationTrigger.OnDelete(wReplicationRef);
        //+REF+REPLIC//

    end;




    var
        wReplicationTrigger: Codeunit "Replication Trigger";
        wReplicationRef: RecordRef;
}

