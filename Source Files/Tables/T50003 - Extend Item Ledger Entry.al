tableextension 50003 ExtendItemLedgerEntry extends "Item Ledger Entry"
{
    fields
    {
        field(50001; "Purity(%)"; Decimal)
        {
            Caption = 'Purity(%)';
        }
        field(50002; QC; Boolean)
        {
            Caption = 'QC';
        }
        field(50003; LOD; Decimal)
        {
            Caption = 'LOD';
        }
        field(50004; "Item Substitute"; Code[20])
        {
            Caption = 'Item Substitute';
            ObsoleteState = Removed;
        }
        field(50005; "Source Name"; Text[100])
        {
            Caption = 'Source Name';
        }
        field(50006; "Sales Order No."; Code[20])
        {
            Caption = 'Sales Order No.';
        }

    }

    var
        myInt: Integer;
        recVendor: Record Vendor;
        recCustomer: Record Customer;

        recItem: Record Item;
        recSalesShipmentHeader: Record "Sales Shipment Header";

    procedure GetSourceName()
    begin
        IF ("Source Name" = '') THEN BEGIN
            IF ("Entry Type" = "Entry Type"::Purchase) THEN BEGIN
                IF recVendor.GET("Source No.") THEN
                    "Source Name" := recVendor.Name;
            END ELSE
                IF ("Entry Type" = "Entry Type"::Sale) THEN BEGIN
                    IF recCustomer.GET("Source No.") THEN
                        "Source Name" := recCustomer.Name;
                END;
        END;
    end;

    procedure GetSalesOrderNo()
    begin
        if ("Sales Order No." = '') then begin
            If ("Document Type" = "Document Type"::"Sales Shipment") then
                if recSalesShipmentHeader.GET("Document No.") then
                    "Sales Order No." := recSalesShipmentHeader."Order No.";
        end;

    end;

    procedure UpdateItemDescription()
    begin
        if (Description = '') then begin
            if recItem.Get("Item No.") then
                Description := recItem.Description;
        end;
    end;
}