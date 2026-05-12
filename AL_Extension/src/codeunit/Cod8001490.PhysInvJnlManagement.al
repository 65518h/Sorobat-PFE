Codeunit 8001490 "Phys. Inv. JnlManagement"
{
    // //+REF+PHYS_INV CW 09/12/09

    Permissions = TableData "Item Journal Template" = imd,
                  TableData "Item Journal Batch" = imd;

    trigger OnRun()
    begin
    end;

    var
        Text000: label '%1 journal';
        Text003: label 'DEFAULT';
        Text004: label 'Default Journal';


    procedure LocationSelection(var pRec: Record "Phys. Inv. Journal Line"; var JnlSelected: Boolean)
    var
        lLocation: Record Location;
    begin
        JnlSelected := true;
        /*
        ItemJnlTemplate.RESET;
        ItemJnlTemplate.SETRANGE("Form ID",FormID);
        ItemJnlTemplate.SETRANGE(Recurring,RecurringJnl);
        ItemJnlTemplate.SETRANGE(Type,FormTemplate);
        */
        case lLocation.Count of
            0:
                ;
            /*
                BEGIN
                  lLocation.INIT;
                  ItemJnlTemplate.Recurring := RecurringJnl;
                  ItemJnlTemplate.VALIDATE(Type,FormTemplate);
                  ItemJnlTemplate.VALIDATE("Form ID");
                  IF NOT RecurringJnl THEN BEGIN
                    ItemJnlTemplate.Name := FORMAT(ItemJnlTemplate.Type,MAXSTRLEN(ItemJnlTemplate.Name));
                    ItemJnlTemplate.Description := STRSUBSTNO(Text000,ItemJnlTemplate.Type);
                  END ELSE BEGIN
                    IF ItemJnlTemplate.Type = ItemJnlTemplate.Type::Item THEN BEGIN
                      ItemJnlTemplate.Name := Text001;
                      ItemJnlTemplate.Description := Text002;
                    END ELSE BEGIN
                      ItemJnlTemplate.Name :=
                        Text005 + FORMAT(ItemJnlTemplate.Type,MAXSTRLEN(ItemJnlTemplate.Name) - STRLEN(Text005));
                      ItemJnlTemplate.Description := Text006 + STRSUBSTNO(Text000,ItemJnlTemplate.Type);
                    END;
                  END;
                  ItemJnlTemplate.INSERT;
                  COMMIT;
                END;
            */
            1:
                lLocation.Find('-');
            else
                JnlSelected := Page.RunModal(0, lLocation) = Action::LookupOK;
        end;
        if JnlSelected then begin
            pRec.FilterGroup := 2;
            pRec.SetRange("Location Code", lLocation.Code);
            pRec.FilterGroup := 0;
        end;

    end;


    procedure OpenJnl(var CurrentJnlBatchName: Code[10]; var pRec: Record "Phys. Inv. Journal Line")
    begin
        CheckLocation(pRec.GetRangemax("Location Code"), CurrentJnlBatchName);
        pRec.FilterGroup := 2;
        pRec.SetRange("Journal Batch Name", CurrentJnlBatchName);
        pRec.FilterGroup := 0;
    end;


    procedure CheckLocation(CurrentLocation: Code[10]; var CurrentJnlBatchName: Code[10])
    var
        lPhysInvJnlBatch: Record "Phys. Inv. Journal Batch";
    begin
        lPhysInvJnlBatch.SetRange("Location Code", CurrentLocation);
        if not lPhysInvJnlBatch.Get(CurrentLocation, CurrentJnlBatchName) then begin
            if not lPhysInvJnlBatch.Find('-') then begin
                lPhysInvJnlBatch.Init;
                lPhysInvJnlBatch."Location Code" := CurrentLocation;
                //??    lPhysInvJnlBatch.SetupNewBatch;
                lPhysInvJnlBatch.Name := Text003;
                lPhysInvJnlBatch.Description := Text004;
                lPhysInvJnlBatch.Insert(true);
                Commit;
            end;
            CurrentJnlBatchName := lPhysInvJnlBatch.Name
        end;
    end;


    procedure CheckName(CurrentJnlBatchName: Code[10]; var pRec: Record "Phys. Inv. Journal Line")
    var
        ItemJnlBatch: Record "Item Journal Batch";
    begin
        ItemJnlBatch.Get(pRec.GetRangemax("Location Code"), CurrentJnlBatchName);
    end;


    procedure SetName(CurrentJnlBatchName: Code[10]; var pRec: Record "Phys. Inv. Journal Line")
    begin
        pRec.FilterGroup := 2;
        pRec.SetRange("Journal Batch Name", CurrentJnlBatchName);
        pRec.FilterGroup := 0;
        if pRec.Find('-') then;
    end;


    procedure LookupName(var CurrentJnlBatchName: Code[10]; var pRec: Record "Phys. Inv. Journal Line"): Boolean
    var
        PhysInvJnlBatch: Record "Phys. Inv. Journal Batch";
    begin
        Commit;
        PhysInvJnlBatch."Location Code" := pRec.GetRangemax("Location Code");
        PhysInvJnlBatch.Name := pRec.GetRangemax("Journal Batch Name");
        PhysInvJnlBatch.FilterGroup := 2;
        PhysInvJnlBatch.SetRange("Location Code", PhysInvJnlBatch."Location Code");
        PhysInvJnlBatch.FilterGroup := 0;
        if Page.RunModal(0, PhysInvJnlBatch) = Action::LookupOK then begin
            CurrentJnlBatchName := PhysInvJnlBatch.Name;
            SetName(CurrentJnlBatchName, pRec);
        end;
    end;


    procedure OnAfterInputItemNo(var Text: Text[1024]): Text[1024]
    var
        lItem: Record Item;
        lInteger: Integer;
    begin
        if Text = '' then
            exit;

        if Evaluate(lInteger, Text) then
            exit;

        lItem."No." := Text;
        if lItem.Find('=>') then
            if CopyStr(lItem."No.", 1, StrLen(Text)) = UpperCase(Text) then begin
                Text := lItem."No.";
                exit;
            end;

        lItem.SetCurrentkey("Search Description");
        lItem."Search Description" := Text;
        lItem."No." := '';
        if lItem.Find('=>') then
            if CopyStr(lItem."Search Description", 1, StrLen(Text)) = UpperCase(Text) then
                Text := lItem."No.";
    end;


    procedure Import(pLocationCode: Code[10]; pJnlBatchName: Code[10])
    var
        lPhysInvJournalBatch: Record "Phys. Inv. Journal Batch";
    begin
        lPhysInvJournalBatch.SetRange("Location Code", pLocationCode);
        lPhysInvJournalBatch.SetRange(Name, pJnlBatchName);
        /*GL2024 NAVIBAT if (not ISSERVICETIER) then begin
             Xmlport.RunModal(Xmlport::"Phys. Inv. Import", true, lPhysInvJournalBatch);
         end else begin
             //XMLPORT.RUN(Number [, ReqWindow] [, Import] [, Record])
         end;*/
    end;


    procedure CompressJournalLine(pLocation: Code[10]; pName: Code[10])
    var
        lRec: Record "Phys. Inv. Journal Line";
        lxRec: Record "Phys. Inv. Journal Line";
    begin
        with lRec do begin
            SetRange("Location Code", pLocation);
            SetRange("Journal Batch Name", pName);
            if FindSet then
                repeat
                    if ("Bar Code" = lxRec."Bar Code") and
                       ("Item No." = lxRec."Item No.") and
                       ("Variant Code" = lxRec."Variant Code") and
                       ("Unit of Measure Code" = lxRec."Unit of Measure Code") and
                       ("Relegation Code" = lxRec."Relegation Code") then begin
                        Quantity += lxRec.Quantity;
                        "Quantity (Base)" += lxRec."Quantity (Base)";
                        "Relegation Quantity" += lxRec."Relegation Quantity";
                        "Relegation Qty. (base)" += lxRec."Relegation Qty. (base)";
                        Modify;
                        lxRec.Delete;
                    end;
                    lxRec.Copy(lRec);
                until Next = 0
        end;
    end;


    procedure SetQtyPhysInventory(var pItemJournalLine: Record "Item Journal Line")
    var
        lRec: Record "Phys. Inv. Journal Line";
    begin
        with lRec do begin
            SetCurrentkey("Location Code", "Item No.", "Variant Code");
            SetRange("Location Code", pItemJournalLine."Location Code");
            SetRange("Item No.", pItemJournalLine."Item No.");
            SetRange("Variant Code", pItemJournalLine."Variant Code");
            if not IsEmpty then begin
                CalcSums("Quantity (Base)");
                pItemJournalLine."Qty. (Phys. Inventory)" := "Quantity (Base)";
            end;
        end;
    end;


    procedure ItemJnlPostLine(var pItemJournalLine: Record "Item Journal Line")
    var
        lRec: Record "Phys. Inv. Journal Line";
    begin
        with lRec do begin
            SetCurrentkey("Location Code", "Item No.", "Variant Code");
            SetRange("Location Code", pItemJournalLine."Location Code");
            SetRange("Item No.", pItemJournalLine."Item No.");
            SetRange("Variant Code", pItemJournalLine."Variant Code");
            DeleteAll;
        end;
    end;
}

