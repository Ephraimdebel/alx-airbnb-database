# Database Normalization (1NF → 3NF)

## 1NF (First Normal Form)
- All attributes are **atomic** (no multi-valued or repeating groups).
- Each table has a **primary key**.
- Example: Instead of storing multiple phone numbers in one field, each phone number would be stored as a separate row in a related `Phone` table.

## 2NF (Second Normal Form)
- Satisfies **1NF**.
- All **non-key attributes** are fully dependent on the **whole primary key**.
- Since our schema mostly uses **single-column primary keys (id)**, there are **no partial dependencies**.
- Example: In the `Booking` table, attributes like `check_in` and `check_out` depend only on `booking_id` (not partially on user_id or property_id).

## 3NF (Third Normal Form)
- Satisfies **2NF**.
- No **transitive dependencies** (non-key attributes must depend only on the primary key).
- Example: Host details (name, email, etc.) are stored in the `User` table, not repeated in the `Property` table.  
  Instead, `Property` stores only `host_id` → referencing `User`.

---

✅ Final Design is in **3NF**:
- No repeating groups.  
- No partial dependencies.  
- No transitive dependencies.  
