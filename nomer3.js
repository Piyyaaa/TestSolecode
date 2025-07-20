function hitungDendaPerBuku(tanggalKembali, tanggalPinjam, daftarBuku, batasMaxPinjaman = 14, dendaHarian = 1000) {
    const tglKembali = new Date(tanggalKembali);
    const tglPinjam = new Date(tanggalPinjam);

    const selisihHari = Math.ceil((tglKembali - tglPinjam) / (1000 * 60 * 60 * 24));
    const hariTerlambat = Math.max(0, selisihHari - batasMaxPinjaman);

    const hasil = daftarBuku.map(buku => {
        return {
            judul: buku.judul,
            denda: hariTerlambat * dendaHarian
        };
    });

    return hasil;
}

// ===========================
// Contoh penggunaan:

const daftarBuku = [
    { judul: "Pemrograman JavaScript" },
    { judul: "Database MySQL" },
    { judul: "Desain UI/UX" }
];

const tanggalPinjam = "2025-07-01";
const tanggalKembali = "2025-07-20";
const batasMaxPinjaman = 14;
const dendaHarian = 2000;

const hasilDenda = hitungDendaPerBuku(
    tanggalKembali,
    tanggalPinjam,
    daftarBuku,
    batasMaxPinjaman,
    dendaHarian
);

// Cetak hasil ke konsol
console.log("Hasil Denda:");
hasilDenda.forEach(item => {
    console.log(`Judul: ${item.judul}, Denda: Rp${item.denda}`);
});
