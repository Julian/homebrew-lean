class Mathlib < Formula
  desc "Mathematics library for Lean 4"
  homepage "https://github.com/leanprover-community/mathlib4"
  license "Apache-2.0"
  head "https://github.com/leanprover-community/mathlib4.git"

  depends_on "julian/lean/lean"
  depends_on macos: :mojave

  conflicts_with "elan-init", because: "it installs the same binaries"

  def install
    system "lake", "build"
  end

  test do
    (testpath/"hello.lean").write <<~EOS
      import Mathlib.Data.Set.Basic
    EOS
    system bin/"lean", testpath/"hello.lean"
  end
end
