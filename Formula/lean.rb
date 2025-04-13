class Lean < Formula
  desc "Theorem Prover"
  homepage "https://leanprover.github.io/"
  url "https://github.com/leanprover/lean4/archive/refs/tags/v4.19.0-rc3.tar.gz"
  sha256 "b357bfcf0d9ac44644f349cedc59f1315405288f5f9f1e98da412dd222b28a1e"
  license "Apache-2.0"
  head "https://github.com/leanprover/lean4.git"

  # Otherwise you seem to always need to set LEAN_CC
  env :std

  depends_on "cmake" => :build
  depends_on "gmp"
  depends_on "libuv"
  depends_on macos: :mojave

  conflicts_with "elan-init", because: "`lean` and `elan-init` install the same binaries"

  def install
    mkdir "build/release" do
      system "cmake", "../..", *std_cmake_args
      system "make", "-j#{ENV.make_jobs}", "install"
    end
  end

  test do
    (testpath/"hello.lean").write <<~EOS
      def id' {α : Type} (x : α) : α := x

      example (a b : Prop) : a ∧ b -> b ∧ a :=
      by
        intro h
        cases h
        exact ⟨by assumption, by assumption⟩
    EOS
    system bin/"lean", testpath/"hello.lean"
    system bin/"lake", "--help"
  end
end
