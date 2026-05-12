codeunit 50033 "BOM-Explode BOM_CDU51"
{
    //GL2024 Procédure spécifique de la codeunit standard BOM-Explode BOM 51
    PROCEDURE wExplodeItem(VAR Rec: Record "Structure Component");
    VAR
        lToBOMComp: Record "Structure Component";
        lResource: Record Resource;
    BEGIN
        //OUVRAGE
        WITH Rec DO BEGIN
            TESTFIELD(Type, Type::Item);
            IF "No." = "Parent Structure No." THEN
                ERROR(Text000);

            FromBOMComp.SETRANGE("Parent Item No.", "No.");
            lToBOMComp.SETRANGE("Parent Structure No.", "Parent Structure No.");

            NoOfBOMComp := FromBOMComp.COUNT;
            IF NoOfBOMComp = 0 THEN
                ERROR(
                  Text001,
                  "No.");

            lToBOMComp := Rec;
            IF lToBOMComp.FIND('>') THEN BEGIN
                LineSpacing := (lToBOMComp."Line No." - "Line No.") DIV (1 + NoOfBOMComp);
                IF LineSpacing = 0 THEN
                    ERROR(Text002);
            END ELSE
                LineSpacing := 10000;

            FromBOMComp.FIND('-');
            NextLineNo := "Line No.";
            REPEAT
                NextLineNo := NextLineNo + LineSpacing;
                lToBOMComp.TRANSFERFIELDS(FromBOMComp);

                lToBOMComp."Parent Structure No." := "Parent Structure No.";
                lToBOMComp."Line No." := NextLineNo;
                lToBOMComp."Quantity per" := ROUND("Quantity per" * FromBOMComp."Quantity per", 0.00001);
                lToBOMComp.Position := STRSUBSTNO(Position, FromBOMComp.Position);
                lToBOMComp."Installed in Line No." := "Installed in Line No.";
                lToBOMComp."Installed in Item No." := "Installed in Item No.";
                lToBOMComp.INSERT(TRUE);
            UNTIL FromBOMComp.NEXT = 0;

            DELETE(TRUE);
        END;
        //OUVRAGE//
    END;

    PROCEDURE wExplodeStructure(VAR Rec: Record "Structure Component");
    VAR
        lFromBOMComp: Record "Structure Component";
        lToBOMComp: Record "Structure Component";
    BEGIN
        //OUVRAGE
        WITH Rec DO BEGIN
            TESTFIELD(Type, Type::Structure);
            IF "No." = "Parent Structure No." THEN
                ERROR(Text000);

            lFromBOMComp.SETRANGE("Parent Structure No.", "No.");
            //SUBCONTRACTOR
            lFromBOMComp.SETRANGE(Subcontracting, lFromBOMComp.Subcontracting::" ");
            //SUBCONTRACTOR//
            lToBOMComp.SETRANGE("Parent Structure No.", "Parent Structure No.");

            NoOfBOMComp := lFromBOMComp.COUNT;
            IF NoOfBOMComp = 0 THEN
                ERROR(
                  TextStructure,
                  "No.");

            lToBOMComp := Rec;
            IF lToBOMComp.FIND('>') THEN BEGIN
                LineSpacing := (lToBOMComp."Line No." - "Line No.") DIV (1 + NoOfBOMComp);
                IF LineSpacing = 0 THEN
                    ERROR(Text002);
            END ELSE
                LineSpacing := 10000;

            lFromBOMComp.FIND('-');
            NextLineNo := "Line No.";
            REPEAT
                NextLineNo := NextLineNo + LineSpacing;
                lToBOMComp := lFromBOMComp;
                lToBOMComp."Parent Structure No." := "Parent Structure No.";
                lToBOMComp."Line No." := NextLineNo;
                lToBOMComp."Quantity per" := ROUND("Quantity per" * lFromBOMComp."Quantity per", 0.00001);
                lToBOMComp.Position := STRSUBSTNO(Position, lFromBOMComp.Position);
                lToBOMComp."Installed in Line No." := "Installed in Line No.";
                lToBOMComp."Installed in Item No." := "Installed in Item No.";
                lToBOMComp.INSERT(TRUE);
            UNTIL lFromBOMComp.NEXT = 0;

            DELETE(TRUE);

            lToBOMComp.INIT;
            lToBOMComp."Parent Structure No." := "Parent Structure No.";
            lToBOMComp."Line No." := "Line No.";
            lToBOMComp.Description := Description;
            lToBOMComp.INSERT;
        END;
        //OUVRAGE//
    END;

    VAR
        Text000: Label 'A bill of materials cannot be a component of itself.';
        Text001: Label 'Item %1 is not a bill of materials.';
        Text002: Label 'There is not enough space to explode the BOM.';
        FromBOMComp: Record "BOM Component";
        LineSpacing: Integer;
        NextLineNo: Integer;
        TextStructure: Label 'There is nothing to explode for structure %1.';
        NoOfBOMComp: Integer;

}