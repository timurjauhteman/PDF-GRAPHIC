-- Tabel untuk menyimpan materi kuliah (Konteks RAG)
CREATE TABLE materi_ekonomi (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    judul TEXT NOT NULL,
    kategori TEXT, -- Misal: 'Macroeconomics', 'Econometrics'
    konten_materi TEXT, -- Tempat nyimpen teks panjang dari buku/catatan
    embedding VECTOR(1536), -- Untuk pencarian similarity (RAG)
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Tabel untuk Template HTML Kurva Ekonomi
CREATE TABLE template_kurva (
    id SERIAL PRIMARY KEY,
    nama_model TEXT UNIQUE, -- Misal: 'Romer_Growth', 'IS_LM'
    html_template TEXT, -- Kode HTML + JS (Chart.js) mentah
    last_update TIMESTAMP DEFAULT NOW()
);

-- Tabel untuk caching layer hasil render PDF
CREATE TABLE history_pdf (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    materi_id UUID REFERENCES materi_ekonomi(id) ON DELETE CASCADE,
    template_id INTEGER REFERENCES template_kurva(id) ON DELETE CASCADE,
    storage_path TEXT NOT NULL, -- URL atau path dari Supabase Storage
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);
